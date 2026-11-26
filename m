Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699269;
	b=S2noSYxsjLbV+4pHdYnqVnCikS1DT7Q9BVwgT7l0iggUpnnZ78cXfS2Skr4p5gwsTPyA
	 SYk3gk7aqNwTvGASMCx/ZgRD8i5ieBUQcy6pbxdUteKhe8KOcXgly3GReE7RoQsnHNhwv
	 UUmAZCBtgL3BacsFlfc1tM3kA90l1AWQfGmdoICQr7sZd+9TsIxxBZ+lcaT7o4tjCXoUb
	 HA6JymObhc/RdGoTywx0KxpOTjSeN9MnN9CsUN1KzYQT9BchOQ0x6cJOI7nR6zfPZ8aCf
	 Tr371xG1XPt1PeBR3m7AYhagv7s/+qiVsxEUu06XBvAozaPfIeOQQjfk1Nf2yL1m0hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699269;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=JaVwLddjL06wLjnEBOretW2mEzxR0eBwYBGY8pvmHWc=;
	b=Q1aLs3P6J2AbbsRXF22Y6Tat34nRrnsNlbOdOoBKHNycw6pT7cEQ1xaRdKbdUdkfSSZn
	 s7c0UGjcAki9kivmA9jiA2YgFwfynih82g6RqCSTDd/8Ajc5x+rpsTL0JAlEGzOJc2Fsh
	 MRRsQm3eJrvAMMpAW/KD1dwO8VadCj0GHvDyyNLlWMzfo30D/n4elekkLyO8DW1r6ZOpO
	 gWc/+wY+EUOorEQD4n8V9RmQPNxoh7lNkAsH21mE5I9NmJp7PsVkpSUL7viiJR4K0URZG
	 eTgrTDBswG1naOGaLHuUn9J9nUV2i0CfTWovf/zf0QoQiAYoyD7k8En8w2q8iBMRJ5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=CsTUf828;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738EF606A31C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 738EF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=CsTUf828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795699266; bh=cr+KZ7IzXFOWSi0buatt8pPJFehbvIpt09nwtynyWe8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CsTUf8289+L5r5wQcZRCH9d6tdTTNEcFxxOoegje1XNsXnZ/4g60cWngB07xFS4qi
	 c4l0mAGCAPp2EMiEhIITpwVwt5hXd0yh34GCBLdIkQjmooNt5sXQ4svgAM3hfKUFKs
	 rJJ1iFKPVAz2W4L8nunrZo3I0HmCbAzwJxCwDqP9Y/z7OtLo6nx33le2wBJ2moHA+f
	 h+RHlefkeWVd8EU6xOiosRiL68TUFJj6YyYx4BMR01VrUsM7MY9HabfZr0tjXeuZ1x
	 UQYdd64Sdw1FZaWRn06dx84FauK3ybQOarYGlNK2nZALmHwbP9CNzZurZxgx7fpG3p
	 2vrIg01IXPAgQ==
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Date: Thu, 26 Nov 2026 14:21:04 +0100
Subject: [PATCH bpf-next v2 6/7] selftests/bpf: Explicitly disable token in
 token/obj_priv_freplace_prog_fail test
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261126-bpf-relax-get-next-id-v2-6-039e92757f9c@toke.dk>
References: <20261126-bpf-relax-get-next-id-v2-0-039e92757f9c@toke.dk>
In-Reply-To: <20261126-bpf-relax-get-next-id-v2-0-039e92757f9c@toke.dk>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>

Now that we changed the behaviour of libbpf to automatically load the
token fd on object creation, we can no longer rely on the absence of
bpf_object__prepare() preventing the token from being present. Instead,
explicitly disable the token by setting token_path to '\0' in the
token/obj_priv_freplace_prog_fail test.

Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
---
 tools/testing/selftests/bpf/prog_tests/token.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index f2f5d36ae00a..17cd7f176e09 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -797,7 +797,7 @@ static int userns_obj_priv_prog(int mnt_fd, struct token_lsm *lsm_skel)
 }
 
 static int userns_obj_priv_freplace_setup(int mnt_fd, struct priv_freplace_prog **fr_skel,
-					  struct priv_prog **skel, int *tgt_fd)
+					  struct priv_prog **skel, int *tgt_fd, bool fr_token)
 {
 	LIBBPF_OPTS(bpf_object_open_opts, opts);
 	int err;
@@ -813,6 +813,8 @@ static int userns_obj_priv_freplace_setup(int mnt_fd, struct priv_freplace_prog
 	if (!ASSERT_OK(err, "priv_prog__load"))
 		return -EINVAL;
 
+	if (!fr_token)
+		opts.bpf_token_path = "";
 	*fr_skel = priv_freplace_prog__open_opts(&opts);
 	if (!ASSERT_OK_PTR(*skel, "priv_freplace_prog__open_opts"))
 		return -EINVAL;
@@ -830,7 +832,7 @@ static int userns_obj_priv_freplace_prog(int mnt_fd, struct token_lsm *lsm_skel)
 	struct priv_prog *skel = NULL;
 	int err, tgt_fd;
 
-	err = userns_obj_priv_freplace_setup(mnt_fd, &fr_skel, &skel, &tgt_fd);
+	err = userns_obj_priv_freplace_setup(mnt_fd, &fr_skel, &skel, &tgt_fd, true);
 	if (!ASSERT_OK(err, "setup"))
 		goto out;
 
@@ -858,7 +860,7 @@ static int userns_obj_priv_freplace_prog_fail(int mnt_fd, struct token_lsm *lsm_
 	struct priv_prog *skel = NULL;
 	int err, tgt_fd;
 
-	err = userns_obj_priv_freplace_setup(mnt_fd, &fr_skel, &skel, &tgt_fd);
+	err = userns_obj_priv_freplace_setup(mnt_fd, &fr_skel, &skel, &tgt_fd, false);
 	if (!ASSERT_OK(err, "setup"))
 		goto out;
 

-- 
2.56.1

