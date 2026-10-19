Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437954;
	b=iftff58y8uYhfnWZ56/hw1fDVhGMeO52X3/+Bpd1EdHSxB8E2cm7DiEATQFgq6eIjuzk
	 J+0lSLttEcWkX0nkCXQLxGLCEVjZfAO/YjnmTnBEKAr3odkJO7JfIx5d+lNRwj1Gn91k2
	 VZHMvx5fpdTr606gLnfcylUqUbG4mNpM5Du9T6Hl/yidupjEXzAeSJ1GK8cbyPhPqkoFT
	 xKnURvxBfE/EXMTUiL0X/GXYnBidSimkXj1IIrory8JuKRxOtWOIJNZqoXfdGMfob9YhJ
	 YpSijrptJeK1AdW9/WtqfKDHRfUGhdZam4RLCC/dBVtWGKibAs4q+MLjcD5/CckASFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=Gl+QuejblNFV3uEkIxOgOsS4jX0GlJs/ROUNx5zrPn4=;
	b=Dh8CZFNYlkVbNX7MdfjfR6GpaQrECM20i1ZJt3yIfETDameRU70XW7stCy4NoPjZh6lL
	 i8djC1VXPSJD6z30ixlCzI7vcMITy7+UW44lPA8i7PaqBBZ70Hpp+rqGIJIX0G6a2lsXV
	 krN67DVIuotlzDP2cuNQzW83nk6FDPLU6giMiE3IPa9E9LBMEW8R+NU/d/HotIhK+IxLi
	 S21PnIyZbD//hUma4Oj+l/AlqvrV6IIcIZSwiHWHexgWSJYik9Vc9H5G74JR/F5pAXwfR
	 8HoLTN9hKKzKq1JFluSoKpaVcjjmvABAlxwA7RbJOFcwwIpEuwqJhTFgPGcMffX9zOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gYnQr9al;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F7E606A328
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 19:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57F7E606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gYnQr9al
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ab4178ee33so1893844a91.3
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 12:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792437954; x=1793042754; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gl+QuejblNFV3uEkIxOgOsS4jX0GlJs/ROUNx5zrPn4=;
        b=gYnQr9alcw+J9ojP/SdeDo47GsqS10jIYNdvilfzW9uVyvOFI724RKT1A9EsWtQ3bQ
         OgXWmiBiwDCiu/gWReT46D/Rk9VHkHgUrKHIxf0YStCBAljm0BIHRVvWPUYzKX908eUt
         iCuSA6FUQ3dcvqmycwRt4gjLfOklT6OAGxuKl5xqbY72BqpfGdxLXGUQIuf+OJ5g7fu5
         g/W82eNWWUviKy78jCy3BJRjKeND6NWnWoTU9lAqh7g7bOgPK8d9buk+6bjXfb3EBJwv
         ck0cedd6WPJoOke0xDGXsTBf/906L8PkyCNeMlUttfM6CF3DCo/JPd8cengfq/sPfTmR
         TcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792437954; x=1793042754;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gl+QuejblNFV3uEkIxOgOsS4jX0GlJs/ROUNx5zrPn4=;
        b=DJklBYFW/ZSNz/6MfLFkP8RSBpEdxXKxmaY2HLzbJs2sq9WfQDX/r9/5PgCU6KbUSS
         RCPWFtKivtc8pUgeD9KA2OX5vBj2I2kt6MvnkeNJlAdDfSDyJTO8UHx0R5N8TbVNhENS
         9ndoPp1XE4/PlRWfw3qWBNkEgSmOh9oMc4iO+9d788kP87mzFminXN3FJAE0T1QEdJ/L
         ifDJY5pdF/6JZPXdQoCjeLOFwkxb6llkjfEkuzlQm4CLqqAZTrW8Li/Y6HhFObHQbds4
         0bbA0yMjFA/lpnmUej72CwnTMnK9HGZOjKaDvcWkicw9zz/m2ZsCggCvGdh3KUz4bOZy
         pRJA==
X-Forwarded-Encrypted: i=1; AKwUvBwTtCnb94+HhVcuLnm4xOa3YhfMz0D0xQNgfnNA1k7yTLT7/u0FgI96PrckOMrmqqHGJkY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKf34FfxfGjB4B8wI6j7sr16rB001FK2j26YYnm5A6QJ6RVFoZC
	GyJZxroVmVZBoEDU2I/9HXYhZBKaa2UMG/Dzyt73gSYJS27OTDMKSCZy
X-Gm-Gg: AYBFou2fZAXPsxycPvF/Z9f+8YFU9un+ozUyeeLkbQNqNFv0e3dv3wW43hlRxSfht7c
	yuo1yIYH3Pf7kJ55n7J+/aY5DQ1WCpfbF0Gt6+C8s7yJTRRTR/jSWiSA8OcPby7cVVX8eOc07kL
	ZcTS8kAYHLV4LCV424yb98rifI8/axfSWDcZh5692FBG+h13wisIeVb7foWC2cNFfHV35Qu2gRw
	AD3ToA74fuXA2EThp7PzZ/mF60rqEOS9FhhQoI0As1oUJ5FAkDUGHPi6U188R+cM2xN0HawR8Iu
	mYCaPkgKW43pkyKYqDlbd4bZDRr96kVLNCzcAufv5nOK8Kk6V2aJx3VdMvk4QlhpbFykHOEUOGQ
	DKUaS99ag5pxiyvk27Zm6T13tzQWeKYRu5EUr+VdxAqt8LObVCAXZ9ZElHuz6dRhFek8o8Ewgd0
	1Vpz1hKTJUKPH5Av+jh18ljxnaMH4Y+ZUNbddmtlRcBtQ0xfOhJwEuFKzDScS0GXfa/AnSqZkfy
	LICtKL3ohjfSMRLajxJa40xVypk8iU8E0dIkSJb0zh8XlQNzvU8p3hBJVO4hlA75o2moTniz0kq
	K94=
X-Received: by 2002:a17:90b:280e:b0:3ab:be66:ddbf with SMTP id 98e67ed59e1d1-3acef58d853mr6802869a91.54.1792437953584;
        Mon, 19 Oct 2026 12:25:53 -0700 (PDT)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd05c9255sm8977238a91.2.2026.10.19.12.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 12:25:52 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Oct 2026 19:25:50 +0000
Message-Id: <DM9282PWYQD9.21LDVIJ8824AL@gmail.com>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Shuah Khan" <shuah@kernel.org>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Hangbin Liu"
 <liuhangbin@gmail.com>, "Martin Karsten" <mkarsten@uwaterloo.ca>, "Masashi
 Honma" <masashi.honma@gmail.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Add syscall common attrs support
 for link_create
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Leon Hwang" <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <20261019153628.15912-2-leon.hwang@linux.dev>
References: <20261019153628.15912-1-leon.hwang@linux.dev> <20261019153628.15912-2-leon.hwang@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
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

On Mon, Oct 19, 2026 at 08:36 AM Leon Hwang <leon.hwang@linux.dev> wrote:
> +	ret = bpf_log_attr_report_size(&attr_log, 0);
> +	if (ret)
> +		goto put_prog;

can we drop bpf_log_attr_report_size() ?
Nothing is logged when the attach succeeds, so there is no size to
report, and libbpf zeroes attr_common, so log_true_size reads 0 anyway.
Finalizing only when ret < 0 already keeps -EFAULT away from a live link.
Then no need for the 2nd write, the log.c refactoring and the put_prog
label.

Something like this (compile tested only):

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 849bc91..61d100e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5856,8 +5856,11 @@ err_put:
 }

 #define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.path_fd
-static int link_create(union bpf_attr *attr, bpfptr_t uattr)
+static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_attr *attr_common,
+		       bpfptr_t uattr_common, u32 size_common)
 {
+	struct bpf_verifier_log *log;
+	struct bpf_log_attr attr_log;
 	struct bpf_prog *prog;
 	int ret;

@@ -5867,14 +5870,24 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 	if (attr->link_create.attach_type == BPF_STRUCT_OPS)
 		return bpf_struct_ops_link_create(attr);

+	log = bpf_log_attr_create_vlog(&attr_log, attr_common, uattr_common, size_common);
+	if (IS_ERR(log))
+		return PTR_ERR(log);
+
 	prog = bpf_prog_get(attr->link_create.prog_fd);
-	if (IS_ERR(prog))
-		return PTR_ERR(prog);
+	if (IS_ERR(prog)) {
+		bpf_log(log, "Invalid prog_fd.\n");
+		ret = PTR_ERR(prog);
+		prog = NULL;
+		goto out;
+	}

 	ret = bpf_prog_attach_check_attach_type(prog,
 						attr->link_create.attach_type);
-	if (ret)
+	if (ret) {
+		bpf_log(log, "Invalid attach_type.\n");
 		goto out;
+	}

 	switch (prog->type) {
 	case BPF_PROG_TYPE_CGROUP_SKB:
@@ -5953,12 +5966,19 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 			ret = bpf_uprobe_multi_link_attach(attr, prog);
 		break;
 	default:
+		bpf_log(log, "Invalid prog type.\n");
 		ret = -EINVAL;
 	}

 out:
-	if (ret < 0)
-		bpf_prog_put(prog);
+	if (ret < 0) {
+		int err = bpf_log_attr_finalize(&attr_log, log);
+
+		ret = err ? err : ret;
+		if (prog)
+			bpf_prog_put(prog);
+	}
+	kfree(log);
 	return ret;
 }

@@ -6530,7 +6550,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = bpf_map_do_batch(&attr, uattr.user, BPF_MAP_DELETE_BATCH);
 		break;
 	case BPF_LINK_CREATE:
-		err = link_create(&attr, uattr);
+		err = link_create(&attr, uattr, &attr_common, uattr_common, size_common);
 		break;
 	case BPF_LINK_UPDATE:
 		err = link_update(&attr);

pw-bot: cr
