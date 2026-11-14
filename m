Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686433;
	b=SUwDo793N4uCdialfgBUwuFYs4Iie2nG7rzB/Up6oMvePsy7YvtquNF5+cU3iDCElxIR
	 TCd/efbFqbFklqBJT3TbcGOgTXob0iIFnAiHQrs2LvkT9umdJSUjtkUXxkTRK/CjwcswX
	 x3Tr5H/iM6XsQcBayYJHMXM23dFNO/oo8QylVSwgRQW2a8nCwiMCP6LwEwde0DFa8cWMo
	 mESpj0tuNts6exZbH/49YQM3ztbP0sWGB/giCnGwucOHPS+fCzFMk8SL3j202RHkyzzFZ
	 MWv2y60o43MWeONE3MILJXt4GFZe19n2CjD02uEi0A6c3n8vDXNCVhS7jyA1hXXzu3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=juXZDEHRyahZTYjY2PuSCsuNe8sXMwmABT8gLTImTaU=;
	b=YIZhyLNIiFap0iWuPb6sF6iytQYKaux1nDxyuZQYCcAW/sYeo6KUpLF9r218ssJjDZJ7
	 YGXyK9Hc7R0mynOgXMu7qBPoO1ABdRNdS42Wgzw9njzNCZCET5kzc0HcnlGO6hnD9yxY8
	 hI5VMQpLfiMSJ7iMhZHygck4dp4FbNldsqwHFWI4V2CkKo4SZHTZ8O0doVv0XBaoMhRLQ
	 UW+agg41RIjzzJCfKsXDeCwKMfRUAt59h4nQGFk1OpJ1nIMjrImZHa9X6BMzDP0IRbOBe
	 eBy+IFVyST46f8J+XQhbO+knJEgOU25pQQPw4G0tc6q397JJ7CoTmHW1wRMklL4AoNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XZhXKgiF;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DA6606A323
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 20:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53DA6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XZhXKgiF
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b179528d56so1000485a91.3
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 12:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794686433; x=1795291233; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=juXZDEHRyahZTYjY2PuSCsuNe8sXMwmABT8gLTImTaU=;
        b=XZhXKgiFzFI1yrxmnhmAn/lA5Tnt4By3XyZKtYPtjdIHRkQAIHCHyIwwH00LQtTL89
         CiXQ4ZoBU6uJ1eG+xrOQzyiYtD+VxXVmOOyEGExTYxw5yeiXnEmXnLtSch0TdH4u0nWE
         NjYaDnFIOLvpZMdHegfwqZXVdTLUSaaCvGrBZL5oThu4AbQ594m5ZEuoVWHaiv83ta/k
         WiFJF67aAlNYvrc32LmqkRUEVH3UIcCevIGwBmaJYyNv9KzeFsaLpaEy2VcThjcoTojq
         OZ+hx1zZE+OGxqUcssle++Nq1/syUl1eCQpHgHuzkpCyj+qhFZKdAD6jNSAaqUArOXXR
         /2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686433; x=1795291233;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=juXZDEHRyahZTYjY2PuSCsuNe8sXMwmABT8gLTImTaU=;
        b=Bi7EMMe9RukYBGkTI8Q6PyJ8xXtRuCnQyYOHJDEva/Wy1FKbbDnc1KlSGJj+xPBCkf
         syS4HunzJ2SRsVYJtcZklC239cSTDm01oHGR3xnHgk+UWzxUt6hmi0LhYbWERbaQ9ccS
         +qEqI3D0kW1swCqI89l/QGRpZpVi9UgaLbA4VO5xU6ou66wyrkbT6qy5C+L2FFQuoGaG
         CU/GeBWLH0GTxPVgrIsmTIkzvS2HMA3FP4IkzHM4sEilk3khebmkneCIyW57XwnccyP8
         oLjH9l0utdI5KO5cg95421GxcQ551+5hGKD8Zh5TaJdxMP0g8aDznax4L3P1sQnVyI/j
         nunA==
X-Gm-Message-State: APuU4Z+sVff/0/ZhLzBNQquX6KF0CL8FEJzfHrQGtOO/uMLHfAAuJGg+
	BVm6dukqWbC5EwOK7MHYcxo5qyBsT1FNzZHTvXAgC4D8pn0mZnYkuEWX0oOfiQ==
X-Gm-Gg: AYBFou3lvTk3GYN1K02yeHY/ZLDbP1r6Fooio+QPyaU7RgdbHnSqaXq38HgWfCV3C/+
	k9onjGWg4zFTqxnzxNRCZZFxKvJHfb7QBhGJa6gkjl/Tx8ZYTjAhmb1NSYubvqO1yhi1lnFPx52
	kx6PU4PzQQojGl7vukFZ9dvpJL74/MfCDOnza6yS8fljcZpT4TsUjrUCtng3wbcM4rk4DZmHZUb
	0JGPhygpC+Q5rpiHOQQ3ME0QvjPxyMeYnVc6faWUaC7J2pWxk4EImoXM/BpZsG7ZpWz5rZv0Y+K
	/iak0seWvneVNpGP+rcOEoX7Ct7Hu4QXV8koiYCT2r3BGgW4g7TnMHIDKVPjDqAKrOPVcYslB58
	CgOqL9XJ/gpA3ft+DCd7cXUI8+SQ2xlgNZVceRPdS0O99SVjxNTmueHFtWfU4ZrV/Wq0GBfWan7
	F0+nqaSoA8MxY6cATrMeiXrEQmhwchD2TO9zFuxFZDavRzwZnZrTKhb3oWJeEBh3d0lr92J2uBl
	KpT0o33S+26R9zMWc2DjRpDDCv52vpnjA0nVQUgbaTSREtezYhjMAOouGa7VFDxKqkbChzlxhyL
	+3ODn91byK7mCuwOxGxlkXjemiQiP5lH1JHA3NycFVUqNoxVHw+VNSc/NwC1QoJnJBe3YGwBu16
	E5zDUIInZFReYUjMGcLg2/JpWst39yK+YRg==
X-Received: by 2002:a17:90b:1d03:b0:3ac:4e18:238c with SMTP id 98e67ed59e1d1-3b1b0b49dd4mr5808360a91.49.1794686432588;
        Sat, 14 Nov 2026 12:00:32 -0800 (PST)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec43699sm9594213a91.10.2026.11.14.12.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 12:00:32 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Nov 2026 20:00:31 +0000
Message-Id: <DMV78SSW0U92.LH9TAXR0MZ5O@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "David Windsor" <dwindsor@gmail.com>
Cc: <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <a.s.protopopov@gmail.com>
Subject: Re: [PATCH v3 bpf-next 05/11] resolve_btfids: Tag the functions
 that return errors
In-Reply-To: <CAEXv5_i17dJmGp3y_0U_f_xK9-SyC9M4GkLCx=pT=4VoXJ4abg@mail.gmail.com>
References: <20261114051805.683966-1-alexei.starovoitov@gmail.com> <20261114051805.683966-6-alexei.starovoitov@gmail.com> <CAEXv5_i17dJmGp3y_0U_f_xK9-SyC9M4GkLCx=pT=4VoXJ4abg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, Nov 14, 2026 at 11:37 AM David Windsor <dwindsor@gmail.com> wrote:
> Do we also need -EBUSY here as an exception? crypto_enqueue_request
> uses it to mean the request was queued on the backlog (not that it
> failed)

Good point. -EBUSY is not a failure there, -ENOSPC is.
A prog that returns -EBUSY skips the list_add_tail().
crypto_wait_req() then waits for a completion that never comes.

In most other functions -EBUSY is a plain failure, so means_failure()
can't drop it for all.
ccp_enqueue_cmd() and qat_alg_send_message_maybacklog() have such
a backlog too. All three also return -EINPROGRESS.
So drop -EBUSY only if the function returns -EINPROGRESS too.
crypto_enqueue_request() stays a target with -ENOSPC.

Here is proposed follow up... other ideas?

diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
index 0751519..e1afdb6 100644
--- a/tools/bpf/resolve_btfids/fmodret.c
+++ b/tools/bpf/resolve_btfids/fmodret.c
@@ -61,9 +61,15 @@ static bool fits_trampoline(const struct btf *btf, const struct btf_type *func)
  * -EAGAIN, -EMSGSIZE and -EINPROGRESS tell the caller to retry, to go on or to
  * wait, not that the function failed. Their numbers are those of the kernel, in
  * asm-generic/errno.h. The errno.h of the build host can have other numbers.
+ *
+ * ASYNC: the function returns -EINPROGRESS too. Then its -EBUSY is no failure
+ * either. In the crypto API it says that the request is queued on the backlog:
+ * crypto_wait_req() waits after both.
  */
-static bool means_failure(int error)
+static bool means_failure(int error, bool async)
 {
+	if (async && error == -16)
+		return false;
 	return error > -512 && error != -11 && error != -90 && error != -115;
 }
 
@@ -82,13 +88,16 @@ static int cmp_error(const void *va, const void *vb)
  */
 static bool format_tag(char *tag, const int64_t *values, size_t nr, __u32 size)
 {
+	bool async = false;
 	size_t i, n = 0;
 	int errors[nr];
 
+	for (i = 0; i < nr; i++)
+		async |= (int)values[i] == -115;
 	for (i = 0; i < nr; i++) {
 		int error = values[i];
 
-		if ((size == 4 || values[i] == error) && means_failure(error))
+		if ((size == 4 || values[i] == error) && means_failure(error, async))
 			errors[n++] = error;
 	}
 	qsort(errors, n, sizeof(*errors), cmp_error);
diff --git a/tools/testing/selftests/bpf/prog_tests/fmodret_retval.c b/tools/testing/selftests/bpf/prog_tests/fmodret_retval.c
index 1db55d8..281c619 100644
--- a/tools/testing/selftests/bpf/prog_tests/fmodret_retval.c
+++ b/tools/testing/selftests/bpf/prog_tests/fmodret_retval.c
@@ -17,6 +17,7 @@ static const struct {
 	{ "bpf_testmod_retval_minus_one",	"" },
 	{ "bpf_testmod_retval_eperm",		"-2,-1" },
 	{ "bpf_testmod_retval_denied",		"-13" },
+	{ "bpf_testmod_retval_backlog",		"-28" },
 	{ "bpf_testmod_retval_effect",		"-22" },
 	{ "bpf_testmod_retval_effect_late",	"-22" },
 	{ "bpf_testmod_retval_effect_two_regs",	"-22" },
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c
index c6263d7..85722e4 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c
@@ -51,6 +51,14 @@ static __used noinline int bpf_testmod_retval_denied(int a, int b, int c, int d)
 	return d ? -ERESTARTSYS : -EIOCBQUEUED;
 }
 
+/* As crypto_enqueue_request(): next to -EINPROGRESS, -EBUSY is "queued on the backlog" */
+static __used noinline int bpf_testmod_retval_backlog(int free, int may_backlog)
+{
+	if (free)
+		return -EINPROGRESS;
+	return may_backlog ? -EBUSY : -ENOSPC;
+}
+
 /* A caller which gets -EBUSY relies on the unlock */
 static __used noinline int bpf_testmod_retval_effect(struct mutex *lock, int value)
 {
