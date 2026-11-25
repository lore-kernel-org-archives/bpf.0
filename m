Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620799;
	b=x9FQNWXS4lCXBuMiHmGvKJGFDdU+Q0olW9BDAX+yp8Q1kY+Zd27Ibaawy/IPnqcq1iXO
	 QDbcMyMh8Dz+6sDTPl5t/9NBbIF5J4IbwCeQMZjBoC09a453VUOI0JkfRYWrprv0AbcU7
	 rbytw0dflKlLI75R+MZS+c15+gIsS1CvCpBySM04BAurfv+sM6BSAslPhHNe0MnMfED7G
	 Km40kyO61q8xoJNDCYfITr5Zib2ftOjJZ9Bp9mZiG3Ryq9P3fHes1EsDcJS7iL+twj+ew
	 jBRqOtlFfi5dTYfIRIdDJFq70g+IyG/yGSMmShjbvVdfQ+m/IVDRKP/0dpUTOheSruA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620799;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=KlxbSX11WMKA0e2TmA4aayjfvy5OfHrbdIeTEPIMrmk=;
	b=e9v9E0TUFJjhTrRfveDM4ZLnuzirKaIp+5SgSCpbxForG62ylZ6ZQ9eOqa1ff806QId/
	 xSSDVWPR92izoBgTkX6SPpevOQ8Rh/0Sb8gJXA/YAtKAg+T+w45m6UrZb7mz9tqKcBWCG
	 oo+tRXrN4X2F5ta1s0YwwuChB0rBlHgLwKpIOItzap6czUwzpeN/ZwPWt2kF9Nz+LeV8Z
	 3hpoVmgc8LRTbjXUiHTYe9aa6m2dZaX+UGJyrRbLgqjIR0baCwfEpQfDQaIzxjI2st5IO
	 H8CSH1oCjMAiCuwGXnJ1qXi3r/5ghOBC8fDL6uq8bSaH+c9qNL/aa4wQSPlmkw0YFIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=GpmCQARq;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864AF606A329
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 15:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 864AF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=GpmCQARq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795620790; bh=G+aQT7enSbePE/WZulCTQBcm689PVTMrDxApPP4c6hY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GpmCQARq1IXAUBzWlc5E0xQfCa5Rn8JInqgPUUUEGXMuZ0Dwy3CCxK1CnP+FHvFbC
	 JokgyVHaWsh1B5YcLB+3wy2XDLuI+9TXXo1iCWlaS+BFN6fQvm8F//Ngj6dQXmrawu
	 iKDjmV5eWd6jmjPUjBOVFOXgtQ9Ko7xArmEPoYqTJx4mn9p79rnTtMchOSpBohT9er
	 /JKEQjRB2TfZLjWonghXfeCPBnH9CT+AylD6qO6TwTsGUSX4QIUPsBZJPVy0c2tlvQ
	 VRXdjVsdAsvPnjbDYGV4py+uUIWpmZrJoqQ31Z4T28trDvdc1VURb49OPJEMQl1yt+
	 UCl4gIj2x1Tog==
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Date: Wed, 25 Nov 2026 16:31:57 +0100
Subject: [PATCH bpf-next 6/7] selftests/bpf: Explicitly disable token in
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
Message-Id: <20261125-bpf-relax-get-next-id-v1-6-49175227c8cf@toke.dk>
References: <20261125-bpf-relax-get-next-id-v1-0-49175227c8cf@toke.dk>
In-Reply-To: <20261125-bpf-relax-get-next-id-v1-0-49175227c8cf@toke.dk>
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
index f2f5d36ae00a..dcb5e9f2d61e 100644
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
+		opts.bpf_token_path = '\0';
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

