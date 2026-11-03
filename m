Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.54.127.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732503;
	b=VwAXVkYybvhyuGJT1DmKVLB3UlX5SWsndMbipEwqnTrswWGZ+TZ54sItZkdy+nO6VLD1
	 fJSYar2T8b4zmHEYIe3saw9nOy+s1BHWj5wMdSJct1Mmsav+c6IvUBDLbvKOAVc7Lgac8
	 xqt6Nk06wH4H1pF5KLmFUOko27BgdglIem5wuJS5Pw2rEAP2dmf9/nSMytg7vWIfkSIHI
	 tq6P2OsSHShLOPwXhrd1ZCmUW3TrJRXBe1qJ4SIEg1x9gdQXi21mraYM8sDoe7NIcNNmz
	 ay93YnIFBjkaMAfD+LJsKDnTbX782YNEbYBLgDGmFOX3wXDOENOBUQihdWTPAeDWyFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732503;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:In-Reply-To:
	 References:From:Date:Subject:To:Cc:X-Envelope-From;
	bh=AXWG/qhSArt5EnQWuwrCQmFVUH/N2VZPyjnPB/yAPfM=;
	b=xuHv3HPiQ+57VaQWakbCXuNMSokG8abBm0NIrFA33hvAc3Q7acnD4MKdUGTRjamWy/Fa
	 K0E4OE3eI0jlKalyVXnxaDN7YP7wO8MBTeSjvrIsiwLMsz0cZRgPrHWYqZL85EmiYPD3H
	 0gy+/x5p7OSyeZYClVYptjW3h9ApWJCd3vj2/wZ8sECq+xrrEJwndpxERyvLNLqHRQ3Xz
	 +gB//AeOuVRRwXXIexnE+0qZ8d4fxPCrEJ/sTXxcXf1qcSiFqbyUmfEwBV2ix6HJ4sHyX
	 kUm5Vjc9sdXkwT6Nl2pdEIPiMvVUXA+dLw47yDxwwpFEDoy9A3mSECc905Zxq3dpvuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=BAaPCWz1;
	arc=none smtp.remote-ip=198.54.127.131
Received: from out-2z4y-a131.jellyfish.systems (out-2z4y-a131.jellyfish.systems [198.54.127.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93F3606A326
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 19:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B93F3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=BAaPCWz1
Received: from [10.18.116.108] (unknown [151.145.76.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jJybY4JqGz8sWT;
	Tue, 03 Nov 2026 19:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1793732493;
	bh=AXWG/qhSArt5EnQWuwrCQmFVUH/N2VZPyjnPB/yAPfM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=BAaPCWz1uUfEGKbIzSqmR9S+6opNyQR6+VweMaAmkHLpl3AYeaZgFElssmOUbPzns
	 n3pBT+hZ75Y/NofkkyI9xsRFmkMTTgAzPCON6Xtta9F0YD2cmZ9TE02euKbISLk/2H
	 3GsWyNNYO3+FmqGWhe0bcFor8j3DMmZW6BL38k42JD83w9LOM6q/3GQ4R9C6Kp7LR8
	 xPu7haKWdzL8GaVUlWwxo9unxxNyoB/8vEQdL/rEocWbjgbRh7y7WP56J9Nxqpe0vg
	 D7jc9x21EIIiiYNt6PTYveBy/nfj6oDTH2GL5eO8GSyNI4IoHhNAygBJSGA5V3UnaL
	 tNVaacAz673JQ==
Message-ID: <dd8d70dfd9edb739747fb69f215e784a6ec9b8a0.1793732336.git.hi@tychen.cc>
In-Reply-To: <cover.1793732336.git.hi@tychen.cc>
References: <cover.1793732336.git.hi@tychen.cc>
From: Tianyi Chen <hi@tychen.cc>
Date: Wed, 04 Nov 2026 04:01:29 +0900
Subject: [PATCH bpf-next v10 1/4] bpftool: Reset map info before each query in
 show and dump loops
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
    andrii@kernel.org,
    eddyz87@gmail.com,
    ihor.solodrai@linux.dev,
    linux-kselftest@vger.kernel.org,
    skokovmaksimevg@gmail.com,
    daniel@iogearbox.net,
    ast@kernel.org,
    hi@tychen.cc
X-Envelope-From: hi@tychen.cc
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

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

