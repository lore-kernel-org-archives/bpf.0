Received: from out-2uec-a106.jellyfish.systems (out-2uec-a106.jellyfish.systems [63.250.43.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A79A4EC64C
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616041; cv=none; b=OvlJmgqt5ACVL1fhAMtMYfqThs7iZocnY95bdj3g6UP34UPuEqFLj3SNTBRM93GTWZlBSnO31PAm4fAqpEoz2StdfeSORCVi8f3tNLayvAfugnOsJfferQL7daHCvxRT7CwTRBWQSR+tKK2HxIRPY/8RIqOnJuprVJJj9j2lcd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616041; c=relaxed/simple;
	bh=TZlmMwCSAptSOQCNe89KhKXnmRoFY3zLKkFX63FCwdc=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=kfI2Cq1DYoDeWSGBLylBtbGHyKUBe41xxLFutvx7P5My0EmxdIfncrgpknLOfnwe8XqgFxFEyid8OczmnGvsZFccWgQ8K+7Br672DMJTcJkejC9mfCGq4j1iGPggoR1r4myHykIqQVLHYPx8GNbiYwlWlg0KbCGfxh6gqMaFl3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=Dje2TbsH; arc=none smtp.client-ip=63.250.43.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="Dje2TbsH"
Received: from [172.20.10.14] (unknown [151.145.76.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4htp3S3Nyzz6tkR;
	Mon, 28 Sep 2026 17:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1790616023;
	bh=nBJBkN/UDf/U+XYmA3Ugo3eORqVSDHqFXFq9rPkHJCw=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=Dje2TbsHrUPIAaM/iyrEnnSmHEm85rFmiMKfXQQmVV1nnXN8iycQe473bPYV6lRTw
	 Qs48gYYsN6DFf5uoa3HYqHxT8xFyrfL56iaIJUSOlNMUooDWkTOycID3pkcZsXHkNW
	 xwiftj6SvmDD77s59cr46I+eLiWaeAV4FBj6HFX+DdhyIo2uR2TUwIayQvSQpw0cvv
	 x3B76hf214eojfL9X8BikkhkdEaWQTFcwntPKIJtQ2smaouDYm6hHKwTrrTaBh8n7V
	 DO/S0/rqp2GCKBT5zVslzbdvW5X/YJH4LJWXeoFhWBvqpS5JlksX9ZMs0BrkVxst1c
	 69tTotCID57rQ==
Message-ID:
 <14f8779c59411e88bc320f1064a94aa580ca5be8.1790615923.git.hi@tychen.cc>
In-Reply-To: <cover.1790615923.git.hi@tychen.cc>
References: <cover.1790615923.git.hi@tychen.cc>
From: Tianyi Chen <hi@tychen.cc>
Date: Tue, 29 Sep 2026 02:13:21 +0900
Subject: [PATCH bpf-next 1/2] bpftool: Reset map info before each query in
 show and dump loops
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
    andrii@kernel.org,
    eddyz87@gmail.com,
    ihor.solodrai@linux.dev,
    linux-kselftest@vger.kernel.org,
    skokovmaksimevg@gmail.com
X-Envelope-From: hi@tychen.cc
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The kernel copies bpf_map_info from userspace and only fills in the BTF
fields when a map has BTF. Reusing the structure for a later map without
BTF therefore retains the preceding map's BTF IDs.

Clear the structure and restore its length before each query in map
listing, named-map listing, BTF detection and dumping. This prevents
reporting stale BTF IDs, choosing BTF output for mixed map selections,
and formatting a map with another map's key and value types.

Reported-by: Quentin Monnet <qmo@kernel.org>
Link: https://lore.kernel.org/r/3acbe829-06f0-4df4-b57c-a8c7b802ec96@kernel.org
Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 tools/bpf/bpftool/map.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 20d59eab09a1..f84311fa640d 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -647,6 +647,8 @@ static int do_show_subset(int argc, char **argv)
 	if (json_output && nb_fds > 1)
 		jsonw_start_array(json_wtr);	/* root array */
 	for (i = 0; i < nb_fds; i++) {
+		memset(&info, 0, sizeof(info));
+		len = sizeof(info);
 		err = bpf_map_get_info_by_fd(fds[i], &info, &len);
 		if (err) {
 			p_err("can't get map info: %s",
@@ -718,6 +720,8 @@ static int do_show(int argc, char **argv)
 			break;
 		}
 
+		memset(&info, 0, sizeof(info));
+		len = sizeof(info);
 		err = bpf_map_get_info_by_fd(fd, &info, &len);
 		if (err) {
 			p_err("can't get map info: %s", strerror(errno));
@@ -774,6 +778,8 @@ static int maps_have_btf(int *fds, int nb_fds)
 	int err, i;
 
 	for (i = 0; i < nb_fds; i++) {
+		memset(&info, 0, sizeof(info));
+		len = sizeof(info);
 		err = bpf_map_get_info_by_fd(fds[i], &info, &len);
 		if (err) {
 			p_err("can't get map info: %s", strerror(errno));
@@ -952,6 +958,8 @@ static int do_dump(int argc, char **argv)
 	if (wtr && nb_fds > 1)
 		jsonw_start_array(wtr);	/* root array */
 	for (i = 0; i < nb_fds; i++) {
+		memset(&info, 0, sizeof(info));
+		len = sizeof(info);
 		if (bpf_map_get_info_by_fd(fds[i], &info, &len)) {
 			p_err("can't get map info: %s", strerror(errno));
 			err = -1;
-- 
2.55.0

