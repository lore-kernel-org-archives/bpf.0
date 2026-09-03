Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D8143B3DE
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424446; cv=none; b=pvid5NPiEiQwn4JOsQSJ0LeCyEeXueSiYHj2QxWj+rm9utC6pxgWQhHLm3Um8H9kUYAPuzUh2Rvw/goH9Wd2R61ekrj1mYHSlI5ihOySIXwNY8tHgMD0gqb2PlJl5ePF8dqgyEMv7xuGTzYW0sW7juQBJwE039WCAjDGXBqt73M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424446; c=relaxed/simple;
	bh=I0e+W4a3U6kC41xzr5ykUUUaxfof4v/nOm3yIOHxuNA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FSQoO8iqsB9f5qFLAUOv5/a3qbIuSeTA4bh6hdeKzOaT4Df2zN5b8MHmpAZKUsnk47m3BUoa3c9aV1xh4djo4i24hbvy/kYOn9nPoLmSnUpr5I9/XBJTx0vBGGESeizQwsm85nnVWoiZ4JKMVuXPOPYUd9YLndAOTq96wNbnTk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qeu2pvo7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qeu2pvo7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C72F1F00A3A;
	Thu,  3 Sep 2026 08:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788424444;
	bh=TmRMQlkcS2VQDHbPgdgeRZHw7WJIXnTgIZYSEnIjx28=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qeu2pvo76V30gVSz0xw5ajZJahXMzhqxGplKtWbsUCeCIp4127RF5Ayp1YyIhPNjC
	 TENfnIq4CT8Jc7EPXJyLfS/Oxj+++wWOwB5Ej2aoaTzi4UwwHZ5g5GjaDDM6Q9YLsc
	 2r6McYJaf8PIME9F4JFN+1R7zYxa5qYLJsmkhdN3QKme3wNQtqA+OHYjGxqcHhBDRX
	 jxe/k89lju+9pwna4CAELQJxYRu07cftJMnbr1T1CLNL8I3r7vcW3BPqX8oluw5QV5
	 PT9IP9uaVWkWVnKoNDCF+skCUsOx0ZLzD1ZfRfxfElwGPKEjEQSROKOwbdg0YbyDAI
	 LTScAHi4TocSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tools libbpf: Fix signed shift UB in btf_type_info()
Reply-To: sashiko-reviews@lists.linux.dev
To: liujing <liujing@cmss.chinamobile.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260903082616.5096-1-liujing@cmss.chinamobile.com>
References: <20260903082616.5096-1-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 08:34:04 +0000
Message-Id: <20260903083404.9C72F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The commit provides an incomplete fix: it resolves the signed shif=
t undefined behavior in the `btf_type_info()` function but misses the exact=
 same undefined behavior in the `BTF_INFO_ENC()` macro defined in the same =
file (and duplicated in selftests).
--

commit d2829a28ec022a655878147a1269bec0aaf774db
Author: Liu Jing <liujing@cmss.chinamobile.com>

tools libbpf: Fix signed shift UB in btf_type_info()

This commit fixes a signed shift undefined behavior in btf_type_info() by
casting the kflag parameter to an unsigned int before left-shifting by 31
bits.

> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index 4c46d34fc055d..2fda8c916cc35 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -259,7 +259,7 @@ static inline enum btf_func_linkage btf_func_linkage(=
const struct btf_type *t)
> =20
>  static inline __u32 btf_type_info(int kind, int vlen, int kflag)
>  {
> -	return (kflag << 31) | (kind << 24) | vlen;
> +	return (((unsigned int)kflag << 31)) | (kind << 24) | vlen;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but while fixing the signed
shift undefined behavior in btf_type_info(), it looks like the exact
same issue was missed in the BTF_INFO_ENC() macro defined in this same
file.

The BTF_INFO_ENC() macro evaluates !!(kind_flag) << 31:

#define BTF_INFO_ENC(kind, kind_flag, vlen) \
    ((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))

Because !!(kind_flag) yields a signed 32-bit int, shifting it left by 31
bits results in 1 << 31 when kind_flag is non-zero (e.g., when encoding
BTF_KIND_DECL_TAG). Doesn't this also trigger the same undefined behavior
that compilers could exploit to generate corrupted BTF data?

Additionally, it looks like this same macro is duplicated in the selftests
under tools/testing/selftests/bpf/test_btf.h and
tools/testing/selftests/bpf/progs/syscall.c. Should those be updated as
well to ensure a complete fix across both libbpf and the selftests?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903082616.5096=
-1-liujing@cmss.chinamobile.com?part=3D1
