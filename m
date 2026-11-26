Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704707;
	b=N6XB1ccWrWhc7pkxl2NqzDhyXcmDT7aeNaLyZTsm1VYU6OPPrcSswkbiOhZT2s4O5du2
	 DXa+fxjldkaRq+Flj0e90jAU1iNb917qeOgZs0VOALL1zrVBiQCzOKNOiGyr2P3ybVwwL
	 Ubq65PrNE5cz0tZwvDi0iRmIZl89ExBWGFqZbonfU0rNz2cqtiopltgb8SOJYHjRz63Qd
	 /8Wq2TQtI1Hqo6IYhx347T7XxDN4biOXIh722ZiLEslVY3O5JXNrYoklHV7Zf9r47Tyxc
	 EPAzogRNJm+WFbuXlKeHd7X2PT5QUNZ3PuHx9hO77vQHqnK/WtYZRnu5ggnBfAaZ8jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704707;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=Ekt7lE1kfW9PP7cH2fM145WPk70XpQRjK38IkVjWclM=;
	b=U/7J0KoarLb/aBmuZIRThbiC8oIk4//F16YRj3XqXN3TeLiR03iV9xsQ+0TfB7Ijgetq
	 LoiEXWGuaZe4hWTvBnrlVX85UY+RFnMjD5/CYjkgrjf+B2GjJa3mBwueHf4fqF/tn5HnS
	 v9Sh8aVoURkyM8dxLqi0wgpbXhPyXUS8MgeYz7obKmaGy+RoWxYPVfTyH7SnhlmePCr8Y
	 jQFRFLoF4RqdGyIlNiKBtADRuaRaYWfxaWn99VcJCVuIZ0e++b3GtFjouFUeXVJDzOJjB
	 VptU6hty1umkNu3lmjmE13nK0ELDQ0pBSvFp9g5Qnn3XTELi6rEkgWZgfCGBL3vtAqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=X42rQPqN;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111F6606A31C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 14:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 111F6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=X42rQPqN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795704702; bh=LBWdcLnk+eUIlkYDnLCi9wGaRQe+hPdRm8NeCb1+gJA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X42rQPqNae2l493HcuNAdI4l4kmob0jEM+fBFiuZy59okIo8FAWVg0dfDgE4WWPqW
	 Vx+k407Y0RQpnimW8XtETN2xPRPPmNotIBToNKfMy40nUpbCQspd5H/Csbdq6hU29p
	 Zo0sOOJADFCytlbnQH0XBshiRA1RAk5ITfwj9WTyLXkrrVrLWQ0hhY8VVHPADRU6Pf
	 YjK3/RbOLEk7pT6LW8UR3TCn9k+Itl8l4MDwRbSt+MRInZCQOkfQhssJdeek2GLx8C
	 EYOr4lyyGAW3Uk1kZ8mvaD5EGsyx4N7ExyAWebq+WlRW2i4RM5PGIhJJkaangDtUb/
	 x2qtp0XEj/tgQ==
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Date: Thu, 26 Nov 2026 15:51:42 +0100
Subject: [PATCH bpf-next v3 6/7] selftests/bpf: Explicitly disable token in
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
Message-Id: <20261126-bpf-relax-get-next-id-v3-6-338e1d3077e7@toke.dk>
References: <20261126-bpf-relax-get-next-id-v3-0-338e1d3077e7@toke.dk>
In-Reply-To: <20261126-bpf-relax-get-next-id-v3-0-338e1d3077e7@toke.dk>
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
explicitly disable the token by setting token_path to and empty string
in the token/obj_priv_freplace_prog_fail test.

Drop the now redundant bpf_object__prepare() call in the succeeding
test, and update the test comment accordingly.

Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
---
 tools/testing/selftests/bpf/prog_tests/token.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index f2f5d36ae00a..6499db1704bb 100644
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
@@ -821,23 +823,17 @@ static int userns_obj_priv_freplace_setup(int mnt_fd, struct priv_freplace_prog
 	return 0;
 }
 
-/* Verify that freplace works from user namespace, because bpf token is loaded
- * in bpf_object__prepare
- */
+/* Verify that freplace works from user namespace */
 static int userns_obj_priv_freplace_prog(int mnt_fd, struct token_lsm *lsm_skel)
 {
 	struct priv_freplace_prog *fr_skel = NULL;
 	struct priv_prog *skel = NULL;
 	int err, tgt_fd;
 
-	err = userns_obj_priv_freplace_setup(mnt_fd, &fr_skel, &skel, &tgt_fd);
+	err = userns_obj_priv_freplace_setup(mnt_fd, &fr_skel, &skel, &tgt_fd, true);
 	if (!ASSERT_OK(err, "setup"))
 		goto out;
 
-	err = bpf_object__prepare(fr_skel->obj);
-	if (!ASSERT_OK(err, "freplace__prepare"))
-		goto out;
-
 	err = bpf_program__set_attach_target(fr_skel->progs.new_xdp_prog2, tgt_fd, "xdp_prog1");
 	if (!ASSERT_OK(err, "set_attach_target"))
 		goto out;
@@ -858,7 +854,7 @@ static int userns_obj_priv_freplace_prog_fail(int mnt_fd, struct token_lsm *lsm_
 	struct priv_prog *skel = NULL;
 	int err, tgt_fd;
 
-	err = userns_obj_priv_freplace_setup(mnt_fd, &fr_skel, &skel, &tgt_fd);
+	err = userns_obj_priv_freplace_setup(mnt_fd, &fr_skel, &skel, &tgt_fd, false);
 	if (!ASSERT_OK(err, "setup"))
 		goto out;
 

-- 
2.56.1

