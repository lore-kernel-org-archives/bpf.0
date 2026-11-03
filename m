Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793714396;
	b=Y4R0WK0v7UWFW+JTOk5Y5rqEzSkT2lng1eNvc38J0dQlfyhA6iXZ1veM1YuCQYc7XYhF
	 wWS8t+opJN24ixrvZCmkgh2sJwPuMIeHCZQrxqDUkgjkFu6MUFuZnTBdxTGBrxf5e3Dbw
	 bFBeGN7hjRVPi9SAd06juYye/hNXbJnt2g+PicU8IkEQozbDRIVGjaCg2IafKvJeywVPo
	 P/hdyVQU+SzlxWffJNDbgrKKiOGkCvNpu7m0cehOvkb0KKpqlOJEO8jwnHbpw8aoh+L1K
	 ZfeuGp//glTVaYhy8X9tpmOQWV0RPgpcNLpJnMRPjz7Sl5uV9YzoGs1Ly3vB+162d4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714396;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KIipZjig14H8lJmsSF4jjlP+SZ/ZdCYhKJ4RJl3Qdjg=;
	b=n0XKKZy768k4X50435c/+Bgr4lNxukd/c5hgXtTJDFJ1AFOA6q2THkxzO7sN8VHbgQZQ
	 vXpIBq7NCBc+3hX1qcoUSwez3jZt9yrF9SQNIIxsFIRb2GrQr23aLABhuek0FBYCn2U+G
	 7AEB+Id9wpPuFiVQ+M1SaCfOJWKrq+vcLEOkh663itYB4P0yb9FB0A+tGD7g9lfr5yU7y
	 WZP8+1BwtXpS8G87jNEHRwyiBtPZq9RgsUOlw3+mQaJOFnOH2B/mXx4m/mpEkWa+87acq
	 mtQjRX8zKpNz2TlNhyFdQW2xioJ81/E3wSZEbzjm9SFMzW75IjsTtgXXg6DE+2P5w1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8xu2yN9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7D3606D809;
	Tue,  3 Nov 2026 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8xu2yN9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793714396;
	b=BAffGAZvPEjZjNrd5LJevP4DSAf3+qKTGkbxzft2eeUbtAD44J//bXeduYJZFVx7l6le
	 JoEJHUVcSiMVnjn9q8EWSO/Euld1WVZ6PS6j7Yf0SFnUgDeCVz7bk0Pjl4IHyBzqZovO+
	 a5GDfknNSR4IHRUyUGFhnRbTwUWZj8sX8aLbK4VrscCp+LMT8aM53PFY8t28P7ilVDQxd
	 o2nQTrCeRdiLrPPQzCEpQzo4FDcUZF9kQGiSOBeT77FhX11OB4OiehMhFnUH0o/JeZO5C
	 UyWcS3h2WM+3JqV4jfaMyOMEaOXan1LT9q/NKFreXUvPmdVlAcgA6wk9CZBP/GLHncw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793714396;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KIipZjig14H8lJmsSF4jjlP+SZ/ZdCYhKJ4RJl3Qdjg=;
	b=q+7hZxxrxxTOtj+rj4Y1ViBk7LNwRv3nfJURY1tjcuUUDQ5Gv8UnhKOh3Ct/zrE5JDaN
	 K6XRMIT7oRdJkqf+o4LLw/w7Fq7n7nPA83BZLtpUOVdboTsDVlJUYUUVprDzqohYzIe51
	 Q5WwnyxrPf0TNm99cGuEWfxiZv6oZmWKsooiZ2eGatdyVGgyS1O8S2J8gnCW0iUK8KDgI
	 wQkLItzw8UTt2gll928fY/xi7JVzaiIb3EpvtPIvesbd91fB4FQJS4l3ktBU6qQYeCLiI
	 3NTOgMToMAL5pIMQaS3MA38XwxgujIOiPFe7AvqU3euEAwHYKpCNyy5kq+IZ+CAqRww==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BA9691F0093A;
	Tue,  3 Nov 2026 13:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793714396;
	bh=KIipZjig14H8lJmsSF4jjlP+SZ/ZdCYhKJ4RJl3Qdjg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=k8xu2yN9s6uE1enF1L2kE5k82wkVWDTk3iCAfe5IvosD5sjmVltnp3Wx+7YkhHzeU
	 3raBsLRu3y/3ap4kjvb1ylnofThdwXXJYRnCnVRxTcBpmceWxcFTU4awwmq2Pwpzxq
	 w43l4ggRxFxhCFEZBcD8KFmstxSuuuDccmFEzt0gHwl2d0BXnB+Oo0oGpqM98s6lTM
	 zJIsSucRMqaMIfkyHuOv2Kd/JCT3hJ6LWSeitlBa1yvHkNccNXX7ff9hVp0F4ESng3
	 fmH1xwingIwp3sWp8FOs/3k38ob0MvAIuQt3IF9TmmgBpTfsjQi3Xg/NHAocmkTRdX
	 Jwzgrf8xfVqrQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3A43146985;
	Tue,  3 Nov 2026 13:59:54 +0000 (UTC)
From: Mark Korenberg via B4 Relay <devnull+socketpair.gmail.com@kernel.org>
Date: Tue, 03 Nov 2026 18:59:54 +0500
Subject: [PATCH bpf-next v5 2/3] bpftool: Don't require a disassembler to
 dump a JITed program to a file
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
Message-Id: <20261103-bpftool-plugin-v5-2-683e08a25df0@gmail.com>
References: <20261103-bpftool-plugin-v5-0-683e08a25df0@gmail.com>
In-Reply-To: <20261103-bpftool-plugin-v5-0-683e08a25df0@gmail.com>
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
 Mark Korenberg <socketpair@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793714393; l=1265;
 i=socketpair@gmail.com; s=20260603; h=from:subject:message-id;
 bh=YA3fRuAfEUIVwaShslcQVsu+SC7z7OAIjbkZp9Lhxg0=;
 b=Z1J5xoIL49fKB2/6kCpqsAROwLn77sNLXyfAPF2ORHGm7kAnGSTxyan1auk6kRSUjMkiR2WI5
 KCduzWdu52ZDu0nmPhTrlj+6w6t3kpQTrqmmq4euw27vHcl+W9dqkxB
X-Developer-Key: i=socketpair@gmail.com; a=ed25519;
 pk=2iAMjWhs7kA9X8ccetT2YVX8dvniXua2okQogw3Don8=
X-Endpoint-Received: by B4 Relay for socketpair@gmail.com/20260603 with
 auth_id=806
X-Original-From: Mark Korenberg <socketpair@gmail.com>
Reply-To: socketpair@gmail.com
Content-Transfer-Encoding: 7bit

From: Mark Korenberg <socketpair@gmail.com>

"bpftool prog dump jited PROG file FILE" only writes the JITed image to
FILE, but do_dump() calls disasm_init() before it parses the arguments,
so the command fails when bpftool has no disassembler.

Call disasm_init() only when the image is disassembled.

Fixes: 29a9c10e4110 ("bpftool: make libbfd optional")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Mark Korenberg <socketpair@gmail.com>
---
 tools/bpf/bpftool/prog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 43599c79c93ac..15efc6eebffb1 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -894,8 +894,6 @@ static int do_dump(int argc, char **argv)
 	int err = -1;
 
 	if (is_prefix(*argv, "jited")) {
-		if (disasm_init())
-			return -1;
 		mode = DUMP_JITED;
 	} else if (is_prefix(*argv, "xlated")) {
 		mode = DUMP_XLATED;
@@ -959,6 +957,8 @@ static int do_dump(int argc, char **argv)
 		p_err("'visual' is not compatible with JSON output");
 		goto exit_close;
 	}
+	if (mode == DUMP_JITED && !filepath && disasm_init())
+		goto exit_close;
 
 	if (json_output && nb_fds > 1)
 		jsonw_start_array(json_wtr);	/* root array */

-- 
2.56.0


