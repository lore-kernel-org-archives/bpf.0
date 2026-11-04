Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.54.127.90
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818507;
	b=MqWSAGGYjUvOPdPXKfEPaPfkXGQDvlLA5exs4k25zX658N6AKht3F+dJvTn6axE8s9/4
	 FriNVs1IDDGiHVQoFOH8UAqm2u57pjnG7GU+zg9m2rbZyX4vhEjRwUdhZKdrKzV8Uo1ih
	 U7rHQemJqWOEJTWp2ztjKG8Hm/rsJuj00k3d04PVF3aaVAuDAGyITd1/5w7hxultT3umO
	 208scF7RHTvQ+w4hxNxATJulFQOsli+kSououUkWJ9oXJ1As5SUJo1p3JsTFV/wJd5pdJ
	 sFT4nKb4yzg6o+qs0YbmagJqtbgaAQgyfsyYnw6CMNfVb+vZQ5/f2t8zEc1ozaTqVNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818507;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Envelope-From;
	bh=AXWG/qhSArt5EnQWuwrCQmFVUH/N2VZPyjnPB/yAPfM=;
	b=xnmdJW+oPJCRdeQSWT175I6qxpkeIVVqQ7mLg3sNAAOUj8dpVFVHsd+zsHgl4O+aadkP
	 sRR/rieABha5G6Xu+hS2izWrjuPcmf8fS52MZXF83L9eAhW5cPSDvGWBiMdFi6mWXeZtM
	 p6KKQceMvo80zpnGzIpdBoqJhE2YQARNH5Km1OYpHihbMMS6r9IAvG2hnrEtpWf9EoBhv
	 cV1O5pJ1SpU3LQ5/lKlCxMzNPhEQ6RhPVC1141qDs/R7XsChkk4tJY0nwL0m+OmuGLV07
	 xt/7edBe67rR8ChdOHETFiMgxppquGG6oJzwqZv37P1OUiOpFJANw9b2cAE7kdD7h5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=hklP4eZJ;
	arc=none smtp.remote-ip=198.54.127.90
Received: from out-zbxj-a90.jellyfish.systems (out-zbxj-a90.jellyfish.systems [198.54.127.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEF2606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 18:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEEF2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=hklP4eZJ
Received: from fedora (ec2-52-197-241-54.ap-northeast-1.compute.amazonaws.com [52.197.241.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jKZPR4kG4z8sWX;
	Wed, 04 Nov 2026 18:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1793818495;
	bh=AXWG/qhSArt5EnQWuwrCQmFVUH/N2VZPyjnPB/yAPfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hklP4eZJPyouccyWBZpazYkxTMR+DiJaFCW9gHld+m2mm+HhfLIlo21EmOi93deDI
	 shUUT3DkbaQV2liL3sZX6Bc9qJLxpX2CCtOvy0BxCQevbQNh1ucgr9MumA5okmcooe
	 cHTsA3u6DKZkB1mObcyQ0fWAHd7dQPcu8/KE4/O7NCXFNnODY6nyrQEVTXJDl0N/ob
	 vdPZthMgsFWVnJDMrpPnJin5yiO+4ol+3C1nD6p8PvTZ9gup4wFtLvgJnJIR4t/IiV
	 22CQMYa4qMep+R2YlnZrkLBSpvcfohxUtdCbxdFDAtW2Xmr8mtrwPRkuYNoe3Q+O9+
	 g1vTANMIuZ6Fw==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	qmo@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	alexei.starovoitov@gmail.com,
	skokovmaksimevg@gmail.com
Subject: [PATCH bpf-next v11 1/3] bpftool: Reset map info before each query in show and dump loops
Date: Thu,  5 Nov 2026 03:54:37 +0900
Message-ID: <0adb4f97dffd5e63319d28e5dea44a96f564dcea.1793818386.git.hi@tychen.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793818386.git.hi@tychen.cc>
References: <cover.1793818386.git.hi@tychen.cc>
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
index 4b65edf74859b..b150a06a25085 100644
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
@@ -970,6 +976,8 @@ static int do_dump(int argc, char **argv)
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

