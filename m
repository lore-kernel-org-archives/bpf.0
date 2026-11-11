Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=63.250.43.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381592;
	b=iJQv9RCGlfIjXUpFoJ2VrqCG6a1befegUbeBfDQ/RMPIQFI2CbPeGeah/EM2/6tAzK8I
	 OF1K+3IB2k4YWYfB6eLn2VC7yKcuuYelN7yp4x39Xb+0fItjNeH3UNp5CGIc7bNghmcfJ
	 Wgdqwlb5jIYLJ+MGFIzDs/WVTmQMG36whO0LR/iiCWao8/mcHnMrCnYfs923vlnSgVHDr
	 FUTzrjdo/xVnlG4CLcprI+PhgbToWVZiSEGfLfKE/QYLRhrUqqltoWoUBvjP/5lR+UxCg
	 rtlcLDDOjQaYfu3GBgKEMaHL9nuichra0169OBQ4wPDD32tJqrvjjTpvEr5Zy5YXJIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381592;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Envelope-From;
	bh=vfoLOZb6kQPEIaWrQc010PwQVsx2URAdaWYwuRotqkA=;
	b=lKd30NsQGaeR4oQ7o6rZ15JziDvQVuR8ZUZ4UC0vz0oLHRrgsF9Z2VOkA6/c+LyasrYr
	 8JzJZeeUFHV6gIRSQTRedn1Th8647BD8okkwFlSaTjIt4QsHSspl5LeeMicuVUxCOt/Ci
	 xJ5E9IsHXhAQ+0tA4hjJ2K+OyAnWTbGxTU7BaAhUgRUb6QyjRyzVDNluMneItZzwm87W0
	 JTA0V32166Gk5TMDIDf3mc6AVKo0NVZTWDDFmDDeU6T4YC18Sr3cgqsvsx24pPO3tZeb3
	 8Ms5G8NGyohau4Lyh29cqcHyyqlLOZsL179qGU+aYAP/G5Zta400IN9UXav760/Eh5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=VE79KQYn;
	arc=none smtp.remote-ip=63.250.43.98
Received: from out-2uec-a98.jellyfish.systems (out-2uec-a98.jellyfish.systems [63.250.43.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7445606A33E
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 07:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7445606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=VE79KQYn
Received: from fedora (unknown [151.145.76.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jPZf43FNmz8sWN;
	Wed, 11 Nov 2026 07:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1794381584;
	bh=vfoLOZb6kQPEIaWrQc010PwQVsx2URAdaWYwuRotqkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VE79KQYnibGZvG6u8d5yxlxu2h9DGDPLH0hr+9285rWRNmSY4yGWvzqBi5GZSBC5K
	 wytLJp0lOYWD8uuaXbQ9/iKvXH5qU6q1zN8In3vtLqi+UxRIUfuOkPjurgTv4xh8p5
	 fRTU4a4MeP3Ve8eiuG43Oyc+dd2nWh1WqVsWlXlnHaNorrM6EjBFbMxx9pfExX4pxn
	 rm/J/kKmOMuDMPNN3Atgs3iPr6J4U5O00H+DwxGrn6zsIGlxWqdAteZR7hKpog2TOs
	 gi2fED7G0qk7QAQE4CSCfYUJxR8x01pE0l7Uk077BpRVtUv0c0MAMDwE1w6KKoh0Pv
	 68B7OuN4oS3gQ==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	qmo@kernel.org,
	ihor.solodrai@linux.dev
Subject: [PATCH bpf-next v12 1/3] bpftool: Reset map info before each query in show and dump loops
Date: Wed, 11 Nov 2026 16:19:25 +0900
Message-ID: <c3606e00253753da2a198d530bbf866a6cd0e103.1794380385.git.hi@tychen.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794380385.git.hi@tychen.cc>
References: <cover.1794380385.git.hi@tychen.cc>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

On kernels that copy bpf_map_info from userspace without clearing output
fields, reusing the structure for a map without BTF retains the preceding
map's BTF IDs.

Clear the structure and restore its length before each query in map
listing, named-map listing, BTF detection and dumping. This prevents
stale BTF IDs and formatting a map with another map's key and value types,
including when bpftool runs on kernels without the kernel-side fix.

Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
Fixes: 99f9863a0c45 ("bpftool: Match maps by name")
Reported-by: Quentin Monnet <qmo@kernel.org>
Link: https://lore.kernel.org/r/3acbe829-06f0-4df4-b57c-a8c7b802ec96@kernel.org
Acked-by: Quentin Monnet <qmo@kernel.org>
Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 tools/bpf/bpftool/map.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index c5c56323f062..9e4dc3881060 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -650,6 +650,8 @@ static int do_show_subset(int argc, char **argv)
 	if (json_output && nb_fds > 1)
 		jsonw_start_array(json_wtr);	/* root array */
 	for (i = 0; i < nb_fds; i++) {
+		memset(&info, 0, sizeof(info));
+		len = sizeof(info);
 		err = bpf_map_get_info_by_fd(fds[i], &info, &len);
 		if (err) {
 			p_err("can't get map info: %s",
@@ -721,6 +723,8 @@ static int do_show(int argc, char **argv)
 			break;
 		}
 
+		memset(&info, 0, sizeof(info));
+		len = sizeof(info);
 		err = bpf_map_get_info_by_fd(fd, &info, &len);
 		if (err) {
 			p_err("can't get map info: %s", strerror(errno));
@@ -837,6 +841,8 @@ static int maps_have_btf(int *fds, int nb_fds)
 	int err, i;
 
 	for (i = 0; i < nb_fds; i++) {
+		memset(&info, 0, sizeof(info));
+		len = sizeof(info);
 		err = bpf_map_get_info_by_fd(fds[i], &info, &len);
 		if (err) {
 			p_err("can't get map info: %s", strerror(errno));
@@ -1038,6 +1044,8 @@ static int do_dump(int argc, char **argv)
 	if (wtr && nb_fds > 1)
 		jsonw_start_array(wtr);	/* root array */
 	for (i = 0; i < nb_fds; i++) {
+		memset(&info, 0, sizeof(info));
+		len = sizeof(info);
 		if (bpf_map_get_info_by_fd(fds[i], &info, &len)) {
 			p_err("can't get map info: %s", strerror(errno));
 			err = -1;
-- 
2.56.0

