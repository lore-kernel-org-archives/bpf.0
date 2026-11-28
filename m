Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795834785;
	b=5iNWeL5LyXpe1D0MTkXay1MfxmSRW0TQbHCn3TdUkkPki53A3XyihYGUoBK+rA6ToH4S
	 wbsrkohLRMECrEtgAT2V4u+BzBuqzDvEDFA7HDCMPdJfOPjADA830f3SZeKaxqFymRD3d
	 kZEIdERU71DDCeE3GBoCi6HUTVWX3FXjG1BwUmq1SCOdKijufBAQrXoYxBX8Pa6SHn0zH
	 3SoC5y3/Io8EX/1cybx8GFqVaQFvD8xWSFs8rxf4p0bxDWhWgL4Sl5t355EkqYIblgjab
	 qXy8KZHJD7UA6N43wmWt6O5bcm+qnaglQsd9o1Js5jBSkCLIkDezI+9a9EU55Ew5BSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795834785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZinI8HvKfdBc0Tt8v4mYwSFmKUUJ46mY/Ci5yekCOuc=;
	b=LbQsxWeukWnSvp/6EOFEuffIV0espjxsWH6yFNgvmwUmf7BMHipm2HKNqNRPS5uIQwiz
	 MFZ+e7wcbpwT2Fu+U2qrpZc47W3Hn2hjyhNHzvdJP6J7zfweLRzTHBBE2oVUitWp/g4fe
	 YaZW2hknrweHVrvfQFcdVCkDyWTYXNACWfyiE9T579NbtDr2JVSWSUlKdA3w9cva5bgid
	 C3B0BTFmjh0qlAY8GhH06xTLDbxrE0rlT1JxNTB8jcAc2h/YaKKz+kEmcDg9b15QQyddv
	 901IY3NIVcRFnjqvOTPMhCXUioBNMhQj/cNDmwgt6KtxUUceDTDktqKYcFc90QSrcIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nsos9Jfj;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BB2606A324
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 02:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87BB2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nsos9Jfj
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cde5a7d7849so3792003a12.0
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 18:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795834785; x=1796439585; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZinI8HvKfdBc0Tt8v4mYwSFmKUUJ46mY/Ci5yekCOuc=;
        b=Nsos9JfjfMpDW/KqAftylNJoySd02BKPhmU0UrTu7RjCtqXhlzV20TKtXjLzajlmZK
         l7zxwpoDroJRHeC3z5vP6Y0iYhPqK0DWnSO/F5GOIg/HfduNEwIu98Nm0F+VX3W9E6Ek
         HfXjZct0y5+mDaZ5c3Lr/XBvL7vTji2nOmcFyavBAXF8lZnny+N2ODSjNRCt7NfPk5wE
         Guj3hqLqoYiWQxH2+Sy+oKeQ8FmARDC+SuCSoXE6fwFkBHfd6MxBoikjJyFRQRn+z0Yt
         EF8303Lg+HrWlGF/PTruEHz1Tt6+mzaIhEkD/ofoJ/FA9r8VZmhPRNuWzeViqJEcsyLw
         /+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795834785; x=1796439585;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZinI8HvKfdBc0Tt8v4mYwSFmKUUJ46mY/Ci5yekCOuc=;
        b=IucD070iNCys68QBWNpvCz0Uf4TQBjRmqF7UvCrIlNo0UEsYp1MlIU+i5vquEMEO8f
         XwBFO8oEBqmyk1NNn07YazrPLpp7S6D9bVJrj7Z756UOQwht74yPzq8fswTHLPBAdarB
         fN3Nhr8ZytYKc/07MR3Qvsn5zbfTXK2n0e5gdgFewEUkY63D7igMKd5pkVwZc7e5cAtJ
         vavnhVNYPYfrNPLH0C15Vo2Ljp+jJB+KpCcAvTZgphzBtDh/WglxsH5DQbGavVKC/LTx
         /zG2VQpmf1ljNQDTCiXAZM8JO4IMXqsXZLuyYmhtodC1A6x7uKDc3YfXbNC2Qw4xZ5pW
         oL3g==
X-Gm-Message-State: APuU4Z8gci/WywLqi9qc3ivE5XmaGzeNmjqURnoaSeMx4oXDbxxb3sjl
	OSE8N/84tEGrEJx6jqHRpd4Rf88KJJDwalF1xhLKmGTdZLnUpYt/kot8
X-Gm-Gg: AZFdTZdcZ6nekH6k4xgSTleOEPyEnhK9/0S8+XR2m8As+eBoXnhRB3WCd3l2SS9X/Cr
	k0pDymZZOkRTH/fmEGLUsE5UWRROXPKFsMVgjklsbgOoGbnl4TZYTohRyGnuIwIO20OM881gbPk
	BgxvCBb9FJ3J4wwZDYLCb1toe3F7nS9lOERpqvSv8DkNXibTtreAU0Sf2ra/jBHunpu2mAobXrG
	CZGfr6rtLafESS+qkCbs8ak8wYPDQ176jNPz6/v0i21pPyNCTtNTXf0wyoAdQ4QoNl5Vi+inQrV
	A7nOjFtPKtgnks/i0odPP6aNIIZpfT8efJC65upJTpvy7ytbsC3iPHAPVD7I6Zf38NilVxCNXWO
	7UEsFhMZhoQTBznf7nta+B/pf8We86kVMUqERH2gnEMlmi72xd1a7dbZm9vH+n46EwBb+22TGz2
	pl4DrMsq2Qx619lXxAMC3WvDWxQzPixGBA7Cy7tY1sAq6c/RICeivF+hutm+ycDKE/jxZ+qVIpf
	uai5EJCBVf4+jq/AHTRJNGx8+VAHRpkGRbpTBcsjsDtq2rEUGQp8EoxHcC9vnyzcdZCjAMuaLsQ
	iA9O/7EnfCodRTAuI+higc+xUjs7o4pFdn+4ys2pEX0E12ncU2Kxok5zUuD9goAGb2G4PwBoMJf
	S8DZecpuVzqf2DiBlU3ZWDrzm/r+r+Z5H4o9BkPubS/u7jKKoQv6r3NnaOQ==
X-Received: by 2002:a17:90b:50:b0:3b0:b35e:b373 with SMTP id 98e67ed59e1d1-3b41c7c2378mr26583289a91.4.1795834784543;
        Fri, 27 Nov 2026 18:59:44 -0800 (PST)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4b3c71192sm24980057a91.5.2026.11.27.18.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 18:59:44 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Nov 2026 02:59:43 +0000
Message-Id: <DN6IAUGCNHGW.1C7HQ1O3S82Q8@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 1/7] bpf: Relax BPF_*_GET_NEXT_ID permission
 checks to CAP_BPF and bpf_token
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>
In-Reply-To: <20261126-bpf-relax-get-next-id-v3-1-338e1d3077e7@toke.dk>
References: <20261126-bpf-relax-get-next-id-v3-0-338e1d3077e7@toke.dk> <20261126-bpf-relax-get-next-id-v3-1-338e1d3077e7@toke.dk>
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

On Thu, Nov 26, 2026 at 06:51 AM Toke Høiland-Jørgensen <toke@toke.dk> wrote:
> Relax the permission check in bpf_obj_get_next_id() to
> token_capable(CAP_BPF), without touching the operations that turn the
> IDs into file descriptors (BPF_*_GET_FD_BY_ID commands). Update the
> capability documentation accordingly.

My bot thinks the following is a better path forward
and I have to agree. wdyt?

This will break libbpf users that have CAP_BPF and no CAP_SYS_ADMIN.
load_module_btfs() relies on EPERM from BPF_BTF_GET_NEXT_ID. See
commit 2d2c95162de8 ("libbpf: Skip modules BTF loading when
CAP_SYS_ADMIN is missing").
libbpf calls it when vmlinux BTF doesn't have a CO-RE type or a ksym.
A missing __weak kfunc is enough.

  step                        today        this patch
  --------------------------  -----------  -----------
  bpf_btf_get_next_id()       EPERM        0
  bpf_btf_get_fd_by_id()      not called   EPERM
  load_module_btfs() returns  0            -EPERM
  bpf_object__load()          ok           fails

The EPERM check in patch 5 helps the new libbpf only.
Released libbpf loads such objects today and fails with this patch.

libbpf needs the FD of the module BTF. The ID is not enough.
BPF_BTF_GET_FD_BY_ID checks bpf_token_capable(token, CAP_SYS_ADMIN).
With a token that is CAP_SYS_ADMIN in the userns of the token.
The prog, map and link variants check capable(CAP_SYS_ADMIN).
They don't take a token.
So CAP_BPF for the walk doesn't help to get the FD.

Lets do the check of BPF_BTF_GET_FD_BY_ID in both commands.
open_flags and fd_by_id_token_fd are in the struct of BPF_*_GET_*_ID
already.

  what                     this series            diff below
  -----------------------  ---------------------  -----------------------
  check without a token    CAP_BPF                CAP_SYS_ADMIN, as today
  uapi/linux/bpf.h         union, second name     no change
  uapi/linux/capability.h  changed                no change
  token code in syscall.c  one more copy          one helper, two users
  new libbpf APIs          4, one has a user      1
  new opts struct          bpf_get_next_id_opts   none
  BPF_F_TOKEN_FD           patch 3 sets it        the caller sets it
  EINVAL from old kernel   retry without token    skip, like EPERM

bpf_token_create() refuses init_user_ns. So the retry without the token
always returns EPERM.

This is instead of patches 1, 2, 3 and 5. The EPERM check of patch 5 is
in the diff. Patch 7 stays as it is.
The token selftests pass with it, and so does the case of patch 7:

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ec8e787..4c3a413 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4872,21 +4872,49 @@ static int bpf_prog_test_run(const union bpf_attr *attr,
 	return ret;
 }

-#define BPF_OBJ_GET_NEXT_ID_LAST_FIELD next_id
+/* The check of BPF_*_GET_NEXT_ID and BPF_BTF_GET_FD_BY_ID */
+static int bpf_obj_id_capable(const union bpf_attr *attr, enum bpf_cmd cmd)
+{
+	struct bpf_token *token = NULL;
+	int err = 0;
+
+	if (attr->open_flags & ~BPF_F_TOKEN_FD)
+		return -EINVAL;
+
+	if (attr->open_flags & BPF_F_TOKEN_FD) {
+		token = bpf_token_get_from_fd(attr->fd_by_id_token_fd);
+		if (IS_ERR(token))
+			return PTR_ERR(token);
+		if (!bpf_token_allow_cmd(token, cmd)) {
+			bpf_token_put(token);
+			token = NULL;
+		}
+	}
+
+	if (!bpf_token_capable(token, CAP_SYS_ADMIN))
+		err = -EPERM;
+
+	bpf_token_put(token);
+	return err;
+}

-static int bpf_obj_get_next_id(const union bpf_attr *attr,
+#define BPF_OBJ_GET_NEXT_ID_LAST_FIELD fd_by_id_token_fd
+
+static int bpf_obj_get_next_id(enum bpf_cmd cmd,
+			       const union bpf_attr *attr,
 			       union bpf_attr __user *uattr,
 			       struct idr *idr,
 			       spinlock_t *lock)
 {
 	u32 next_id = attr->start_id;
-	int err = 0;
+	int err;

 	if (CHECK_ATTR(BPF_OBJ_GET_NEXT_ID) || next_id >= INT_MAX)
 		return -EINVAL;

-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
+	err = bpf_obj_id_capable(attr, cmd);
+	if (err)
+		return err;

 	next_id++;
 	spin_lock_bh(lock);
@@ -5681,32 +5709,11 @@ static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, struct bpf_l

 static int bpf_btf_get_fd_by_id(const union bpf_attr *attr)
 {
-	struct bpf_token *token = NULL;
-
 	if (CHECK_ATTR(BPF_BTF_GET_FD_BY_ID))
 		return -EINVAL;

-	if (attr->open_flags & ~BPF_F_TOKEN_FD)
-		return -EINVAL;
-
-	if (attr->open_flags & BPF_F_TOKEN_FD) {
-		token = bpf_token_get_from_fd(attr->fd_by_id_token_fd);
-		if (IS_ERR(token))
-			return PTR_ERR(token);
-		if (!bpf_token_allow_cmd(token, BPF_BTF_GET_FD_BY_ID)) {
-			bpf_token_put(token);
-			token = NULL;
-		}
-	}
-
-	if (!bpf_token_capable(token, CAP_SYS_ADMIN)) {
-		bpf_token_put(token);
-		return -EPERM;
-	}
-
-	bpf_token_put(token);
-
-	return btf_get_fd_by_id(attr->btf_id);
+	return bpf_obj_id_capable(attr, BPF_BTF_GET_FD_BY_ID) ?:
+	       btf_get_fd_by_id(attr->btf_id);
 }

 static int bpf_task_fd_query_copy(const union bpf_attr *attr,
@@ -6523,15 +6530,15 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = bpf_prog_test_run(&attr, uattr.user);
 		break;
 	case BPF_PROG_GET_NEXT_ID:
-		err = bpf_obj_get_next_id(&attr, uattr.user,
+		err = bpf_obj_get_next_id(cmd, &attr, uattr.user,
 					  &prog_idr, &prog_idr_lock);
 		break;
 	case BPF_MAP_GET_NEXT_ID:
-		err = bpf_obj_get_next_id(&attr, uattr.user,
+		err = bpf_obj_get_next_id(cmd, &attr, uattr.user,
 					  &map_idr, &map_idr_lock);
 		break;
 	case BPF_BTF_GET_NEXT_ID:
-		err = bpf_obj_get_next_id(&attr, uattr.user,
+		err = bpf_obj_get_next_id(cmd, &attr, uattr.user,
 					  &btf_idr, &btf_idr_lock);
 		break;
 	case BPF_PROG_GET_FD_BY_ID:
@@ -6586,7 +6593,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = bpf_link_get_fd_by_id(&attr);
 		break;
 	case BPF_LINK_GET_NEXT_ID:
-		err = bpf_obj_get_next_id(&attr, uattr.user,
+		err = bpf_obj_get_next_id(cmd, &attr, uattr.user,
 					  &link_idr, &link_idr_lock);
 		break;
 	case BPF_ENABLE_STATS:
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 38dcb31..1adfd53 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1149,14 +1149,20 @@ int bpf_prog_test_run_opts(int prog_fd, struct bpf_test_run_opts *opts)
 	return libbpf_err_errno(ret);
 }

-static int bpf_obj_get_next_id(__u32 start_id, __u32 *next_id, int cmd)
+static int bpf_obj_get_next_id(__u32 start_id, __u32 *next_id, int cmd,
+			       const struct bpf_get_fd_by_id_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, open_flags);
+	const size_t attr_sz = offsetofend(union bpf_attr, fd_by_id_token_fd);
 	union bpf_attr attr;
 	int err;

+	if (!OPTS_VALID(opts, bpf_get_fd_by_id_opts))
+		return libbpf_err(-EINVAL);
+
 	memset(&attr, 0, attr_sz);
 	attr.start_id = start_id;
+	attr.open_flags = OPTS_GET(opts, open_flags, 0);
+	attr.fd_by_id_token_fd = OPTS_GET(opts, token_fd, 0);

 	err = sys_bpf(cmd, &attr, attr_sz);
 	if (!err)
@@ -1167,22 +1173,28 @@ static int bpf_obj_get_next_id(__u32 start_id, __u32 *next_id, int cmd)

 int bpf_prog_get_next_id(__u32 start_id, __u32 *next_id)
 {
-	return bpf_obj_get_next_id(start_id, next_id, BPF_PROG_GET_NEXT_ID);
+	return bpf_obj_get_next_id(start_id, next_id, BPF_PROG_GET_NEXT_ID, NULL);
 }

 int bpf_map_get_next_id(__u32 start_id, __u32 *next_id)
 {
-	return bpf_obj_get_next_id(start_id, next_id, BPF_MAP_GET_NEXT_ID);
+	return bpf_obj_get_next_id(start_id, next_id, BPF_MAP_GET_NEXT_ID, NULL);
+}
+
+int bpf_btf_get_next_id_opts(__u32 start_id, __u32 *next_id,
+			     const struct bpf_get_fd_by_id_opts *opts)
+{
+	return bpf_obj_get_next_id(start_id, next_id, BPF_BTF_GET_NEXT_ID, opts);
 }

 int bpf_btf_get_next_id(__u32 start_id, __u32 *next_id)
 {
-	return bpf_obj_get_next_id(start_id, next_id, BPF_BTF_GET_NEXT_ID);
+	return bpf_btf_get_next_id_opts(start_id, next_id, NULL);
 }

 int bpf_link_get_next_id(__u32 start_id, __u32 *next_id)
 {
-	return bpf_obj_get_next_id(start_id, next_id, BPF_LINK_GET_NEXT_ID);
+	return bpf_obj_get_next_id(start_id, next_id, BPF_LINK_GET_NEXT_ID, NULL);
 }

 int bpf_prog_get_fd_by_id_opts(__u32 id,
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index fe3b7fd..b1f0882 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -532,6 +532,8 @@ struct bpf_get_fd_by_id_opts {
 };
 #define bpf_get_fd_by_id_opts__last_field token_fd

+LIBBPF_API int bpf_btf_get_next_id_opts(__u32 start_id, __u32 *next_id,
+				const struct bpf_get_fd_by_id_opts *opts);
 LIBBPF_API int bpf_prog_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_prog_get_fd_by_id_opts(__u32 id,
 				const struct bpf_get_fd_by_id_opts *opts);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 540daf7..b52c143 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6017,6 +6017,9 @@ static bool is_btf_mod_allowed(const struct bpf_object *obj, const char *name)

 static int load_module_btfs(struct bpf_object *obj)
 {
+	LIBBPF_OPTS(bpf_get_fd_by_id_opts, opts,
+		    .open_flags = obj->token_fd ? BPF_F_TOKEN_FD : 0,
+		    .token_fd = obj->token_fd);
 	struct bpf_btf_info info;
 	struct module_btf *mod_btf;
 	struct btf *btf;
@@ -6041,10 +6044,11 @@ static int load_module_btfs(struct bpf_object *obj)
 		return 0;

 	while (true) {
-		err = bpf_btf_get_next_id(id, &id);
+		err = bpf_btf_get_next_id_opts(id, &id, &opts);
 		if (err && errno == ENOENT)
 			return 0;
-		if (err && errno == EPERM) {
+		/* EINVAL: the kernel is too old to take a token here */
+		if (err && (errno == EPERM || (errno == EINVAL && obj->token_fd))) {
 			pr_debug("skipping module BTFs loading, missing privileges\n");
 			return 0;
 		}
@@ -6054,10 +6058,14 @@ static int load_module_btfs(struct bpf_object *obj)
 			return err;
 		}

-		fd = bpf_btf_get_fd_by_id(id);
+		fd = bpf_btf_get_fd_by_id_opts(id, &opts);
 		if (fd < 0) {
 			if (errno == ENOENT)
 				continue; /* expected race: BTF was unloaded */
+			if (errno == EPERM) {
+				pr_debug("skipping module BTFs loading, missing privileges\n");
+				return 0;
+			}
 			err = -errno;
 			pr_warn("failed to get BTF object #%u FD: %s\n", id, errstr(err));
 			return err;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index a45666f..30f199c 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -476,6 +476,7 @@ LIBBPF_1.8.0 {

 LIBBPF_1.9.0 {
 	global:
+		bpf_btf_get_next_id_opts;
 		bpf_program__load;
 		bpf_program__load_strategy;
 		bpf_program__set_load_strategy;

pw-bot: cr
