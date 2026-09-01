Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979662C0F8C
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245342; cv=none; b=eRUe37O5vvogZn7EP38ywuB/YjRXXfUK9yT8CkpmFCCOSjEUgvbQy++Ng600sVA8xNE1Tav6etM39NjsQjHoRnQtU1oKngfBeVyp9Hlb04iVersRogd+Ac7FXoP/vA5HOYB852Z6MiXHFWmfSfCJmw8NIzqZympJLnmG7T59KME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245342; c=relaxed/simple;
	bh=lkIrI0bktrPyMb+NKuF3JmbvLiOro+74TdjXHBXsrRI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b+On9Kje69iDeLOXLYLA7mPVn/mwDBrJRZfykcxLFjmoT/g6Nybo1VDFC8kJFwe2Hnd+FtWj29A0/2cw5Rik4sS9LwnJXZhjiIyUmQAlEEgBBsZ7DlKcPYakkK9aNJG7CG5S6Iv1okwikr+Qk2a8kPO7BZfuAUHsEhNPisciGwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWkE8O/T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWkE8O/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0286F1F000E9;
	Tue,  1 Sep 2026 06:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788245341;
	bh=2NTqZ2xwRffSuGksM7Zuwe8oyoXwOSHQk3uGx2LpS0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RWkE8O/TLoEF61yKtQlZnWORsoSvBU6094upV2ss8ZyTilLg7hQtbBLeIEXRCJUKY
	 AvOGnJ2JXZObkr8DE7d2l5eaywCNUM9wRZI6H913r8icf5a0rM1z7UPw++mfd7lnTX
	 wQWANA78G3FJtsJsZfa4UBwIEo/UkxI03C4b8ABpmUrsuTFlQ4H9b65Paig9FRy9Hg
	 9/4T9L3/lH7k4ueRFeeG3WTfOEhEAz4CWVV5vwk76/JX93Iy4lg//lsK5jTDxq2Us1
	 BFjiaCAhum2ptV6660HO/TpwpUfE6BNVAG3INzSjpWIoMP9Ez3y/WxhKzz5RsrYcjS
	 U1tqObOurRqCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/4] bpf: Cancel special fields in resizable
 hashtab on recycle
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260901062845.1379760-2-chenyuan_fl@163.com>
References: <0560a24d-2cf9-4e5b-aa61-580af1e56de1@gmail.com>
 <20260901062845.1379760-1-chenyuan_fl@163.com>
 <20260901062845.1379760-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 06:49:00 +0000
Message-Id: <20260901064901.0286F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing bpf_obj_free_fields() when overwriting a map value in rhta=
b_map_update_existing(), violating the BPF-001 guideline.
--

commit a386d962d0ebafb2260b7ce5bf02d3879316b1e8
Author: Yuan Chen <chenyuan@kylinos.cn>
bpf: Cancel special fields in resizable hashtab on recycle

This patch updates the resizable hashtab to use bpf_obj_cancel_fields()
instead of eagerly calling bpf_obj_free_fields() on recycle and update
paths. This is intended to prevent running kptr destructors in NMI context.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index d40cb5dd446ca..aaedda3730f37 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -3022,10 +3013,12 @@ static long rhtab_map_update_existing(struct bpf_=
map *map, struct rhtab_elem *el
>  	 * BPF_F_LOCK, matching arraymap semantics.
>  	 *
>  	 * copy_map_value() skips special-field offsets, so old timers/
> -	 * kptrs/etc. still sit in the slot. Cancel them after the copy
> -	 * to match arraymap's update semantics.
> +	 * kptrs/etc. still sit in the slot. Cancel the NMI-safe ones after
> +	 * the copy to match arraymap's update semantics; referenced kptrs
> +	 * stay attached and are destroyed by rhtab_mem_dtor().
>  	 */
> -	rhtab_check_and_free_fields(rhtab, elem);
> +	bpf_obj_cancel_fields(&rhtab->map,
> +			      rhtab_elem_value(elem, rhtab->map.key_size));

[Severity: High]
Does replacing this cleanup cause a resource leak during map updates?

According to the BPF subsystem guidelines, when copy_map_value() overwrites
an existing map value, bpf_obj_free_fields() must be called to release
resources held by the old value.=20

Since the patch removes the underlying bpf_obj_free_fields() call in
rhtab_map_update_existing() and substitutes it with bpf_obj_cancel_fields(),
it appears kptr references might leak when a map value is updated in place.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901062845.1379=
760-1-chenyuan_fl@163.com?part=3D1
