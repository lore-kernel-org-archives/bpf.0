Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB1E156677
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 23:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776035741; cv=pass; b=eVMd6wNFe95mMc7/0tRTlV/s9PFkRiTYxGoXN6FUnO7nrDFgiCJg1uDDvGCSvubfbeeJIEblTNoLLLvWGAqAyoy7E1TNQInQiXzWQw4l2x0J5S7M71tHvD55QWk9myFJbmJsR+R1DLoJPkDJsmOZ0krhsiaMNyiAHhxL5/V/pyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776035741; c=relaxed/simple;
	bh=u6J4fQ+rdazm3+dVF7FE+8SPRm/6wsJtUkbtpxlq0J4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EADBYyrwNFVawLnHyCOxRc6HSU4oufo3TLCSGjUNMm+8dgtCBfhn/z6FbifrSjjdYcT8UThbLCLI/YGCWCRoKs/ewB4ufY0DXUhf92GvZWq6/tyLr6oRc1TAlaHktT8wRnQkJC6ZSERRqRjwX4x30te3t0ewO3xGtUozSEI80QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXHtK/Tz; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXHtK/Tz"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso65003345e9.0
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 16:15:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776035739; cv=none;
        d=google.com; s=arc-20240605;
        b=ZdRa3Z3cRetyqnieJXeuYIEbxmU+rNquBOJdsr6C3LpgxAy3cgH9talt4NxwEHMoPH
         DcHzSL3MT84Gk1Xn2GcbRGCBg36H7W6mPg3JaaLPjVmSDMpuWY6ZWv9e1nRVDTGNutHB
         ksBYUHvsff8dhovEs9IIeZBjEwz1tx5U5q46qTgkIXR0LCAMZGYGAHeKzbPKx4CuEhQ8
         gzm4mAKjMjYlx8erZvqYv1PYwAk8pvaXtOpLMXEXDzJEXfubdXCr3agCLrEYXqVPK2pd
         xt/R43STeD0QdG43TsJqAevS7BZ0itCu1WvrH+SNL5gZMiT8Rjpyjr6f76N+ohx+/Kep
         o/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jbSTLfpjceQei5hrkbF7ESE97kfXLmFRMS6NVAuGGt4=;
        fh=AoyNRaktsZ7bW/hTwiP8Dm5frmwh/+vEg7lx+EPGuMM=;
        b=F0n4ATrbtIW14n3g0/62OrOLQKX6CaRGM4SAJPSDBCKWdo64arvhmqUJbMohS00qYV
         48LkYRvDfXGt6pnh3UpZApNYaM2HBOxeFtoLQNkRXIckUFhu+iv7ztyr6aV5jikZh+8D
         VdmoErEDtvBI68U/lrSVdezuTzrWW8qj/1RclRE54y5eYiPhW1/jCrOWTq3OFzMeqbFG
         dQ/kcrUdXMQb7NMWyE5BMlFCXIGrt7zLRq37SKq9i4fl4s/CCfCx3yMyE7Ed1dgwVgwP
         DZFKYcHNo18m4YZLMFRhv659I6Gy19sRmBKjHpyY8GRkeQwnC1sY8N4uN7KZAN9NRfzZ
         k7OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776035739; x=1776640539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbSTLfpjceQei5hrkbF7ESE97kfXLmFRMS6NVAuGGt4=;
        b=NXHtK/TzuyQzeAeWQvbwxDTP1W5lmo8NWrWY868uqKYRMGlLSTP0owXrKlfNOi/Erd
         5Z8//5FP3yxeWaWXVldyWnBUPCDGtmuu3LBDofRGuiKBde/3NwSBoWkgjxzfhG54ZEfF
         Bw/FMIjxYW9u8D/MJQEx4egNjTRUCocUSX9bALs8cMjJ9GGMVX/9oCGTnXHCnKhxS8ER
         Ft7MusEsU/T7opKpmDWc3CZmsVxTzJIraKi5jgH2wmKbBa4zc1mowqg9pisf9q9QjVd5
         zaCOMxeRqexd19QB0PLLVHq+acLPXSyslvnEcKaRHoiBJ+yYjWFETn3PasV4rPotgR/G
         fA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776035739; x=1776640539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jbSTLfpjceQei5hrkbF7ESE97kfXLmFRMS6NVAuGGt4=;
        b=U8hWtd70/aKReYKIzYXcfPwxL5XFHfSWT+9u3rrWGUtwf+iWides0YybHLFmz8ApcR
         RdlyZHmtcQ11ABL7o4zrUw5ifoksm9FR3wRwNj8kepTB95Mp0JfU0nAWtuzXdsOdpfVj
         uj/ue2R16I/hojP52vbGb2keoNJmqAG9/dVvTOTFRBuZTZqXNBCsiDRVbcaUVzgLL1uT
         9LheucfL9On7eB0Bkwx0KKyQ9iwRZfOsvrwZEdlQwH8rKe5uTeUJfCzxHtM83IkqGYP2
         av8KhTB2JxjASHxnWmvThXerzNFCOzBfr1K/HWRbxv0enY9/VOgdnnmyZyhXiNu3Intd
         KBoA==
X-Gm-Message-State: AOJu0YwhnT9FKql3wor2ZoPP+5Y1RSJ3Q8VUHPeZpZw3rJBqInnXYf2h
	j4GqH5idSwXPStKP/TnHgUZDXNm+SRaClDXBryLzbHLaGbiQag/9WleWrvg0aK0bsKgucu+ivpZ
	xr1ZyzVDY7aTMiHhe2KotTD8crFqaW0w=
X-Gm-Gg: AeBDieurIHztktiJfbTDqvFJ1xL+9ZwqCFccjjkpchDUalx5q4FKKQWHKjad7cWfvvT
	IBEG+vld10CMSAIGuT3DK83rUbzhYbMdtX17nviD8KzTffq/K5KBZvOCsp6RpOOgUCbQOyLUWTd
	H+7VAeaP47hW21o4m64XB1ZCKBQLTzrpCzrEBI8jRGtdOiH52RKC462UMsXJ/ODiAz91luuXOL5
	1hDtQlbGSgtzu7S3WSB77SNLnkFerBkrVb/xO8JQo4pwb715ki1VP9RQVFAPxFNIFWvZcXktfIg
	QmClJJgafF0wMtROzlxfSw2VIbdyPQDxHxaFdNUSo3waVhT+Jst5qH2EeEx6wqGjSdUkZWIqhUx
	7IX89WaFLbYANyPZIIHYMmWkUVA==
X-Received: by 2002:a05:600c:3b29:b0:488:d07a:b178 with SMTP id
 5b1f17b1804b1-488d67c7029mr152420095e9.6.1776035738593; Sun, 12 Apr 2026
 16:15:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com> <20260408-rhash-v2-9-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-9-3b3675da1f6e@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 12 Apr 2026 16:15:26 -0700
X-Gm-Features: AQROBzBnZuxIn0fswPSjj9-mjuLbdpRhta8bZ_GJYuYio7sFIOqhym8Wk5lm-sA
Message-ID: <CAADnVQLpgugNV+FAuxrRwZBh5-XXLQqwVdbOO6WgmmtJrN0t2w@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 09/18] bpf: Implement alloc and free for
 resizable hashtab
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 8:10=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Initialize rhashtable with bpf_mem_alloc element cache. Require
> BPF_F_NO_PREALLOC. Limit max_entries to 2^31. Free elements via
> rhashtable_free_and_destroy() callback to handle internal structs.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/hashtab.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 60 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 492c6a9154b6..a62093d8d1ae 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2762,16 +2762,74 @@ static inline void *rhtab_elem_value(struct rhtab=
_elem *l, u32 key_size)
>
>  static struct bpf_map *rhtab_map_alloc(union bpf_attr *attr)
>  {
> -       return ERR_PTR(-EOPNOTSUPP);
> +       struct bpf_rhtab *rhtab;

patches 6,7,8 are ok as step-by-step,
but this one should be squashed with 1-3
