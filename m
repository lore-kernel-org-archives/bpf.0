Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792618163;
	b=CgQ2fTupQja8J7iaIZR3z05SMeV4JnA1xEUrCQ+Mjyzu384Yb19qtGTBQfm/r6b8eHCi
	 6sIJ9FOFrql0q+zDoW5UtwmBYBlAsShIWG/ndGeEMlvDMyEGm3A3aRMEUg3HP6N+HG1pc
	 Q2W9nO5PwTDwl9paGIEnQas49NjO4Gw8Nh1pKGqIdkFifauAtGVAoiJLnLPguj+m07Ab4
	 pDaMbbN5d9oeABBAN0ePeJ3IGxr//7VEjuZMgtLWovlnGh1sVbqs5djT7gW4Bnco1ll1z
	 FhhnOnmv13t+sjFYJRibD8YnfVQM7qb7+0lWkPr3RS6a4mc44gs2zl2aa6rXg6wlEqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=gpL66/D2iZNZJmKtmfPRZTI2dqc5FxpU7hvuG7+bRBg=;
	b=DPrvQ+lvB+VGr9w13BpWpYH2Up2wDvZBmgGAv5V1RCBk33LDWuXKiKg3D05Roptc5VgY
	 iw224u8TKDboW1z9b1eowK7iH/eKh24XCYu+EJ3iGmAtT2n/Cv8Beu5Yx9qaxui/I6EXG
	 G06WqNt/3Ge49+wiOdtuzqkPVA2hqgKSbJy7uBnEe1Dwe8eVnDm+U2YA239ZpE00qxE14
	 vARZ36OM4b025SLqNn4Z5l5ZpqyIKjUltiOT2xPizxDOFLE6kL37w2/Ad7GATCpQQk3Lr
	 ASjErGE1wy3VpD2+jYil7aaSIdeSwvf88sziqFYH3iYIA511HMaru/WVKIRx2tiZs8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ddppVnau;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16CA606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 21:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E16CA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ddppVnau
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-81ba09a5d23so1131282a34.3
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 14:29:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792618162; cv=none;
        d=google.com; s=arc-20260327;
        b=IrHanjA15FBjpvjJIV3E1UbOmz7KFplajSvCld5L8vCOJl271E+/DpGD+yq84ZG1h4
         B8IZGwv0UfIFWVc4BBQr6OFNq2eYpOHMKVIF17vJTBcEnh1LMpr26JWIqeqfz1gLHY5x
         T9t10/9eNjtA4RPHPiiHA5xOgJELg1vu9g3EssQZpIbu8xll3x/jJvYiNhVm4tB5c4cY
         TlAAb6w9W09N8YgaZzT4phIvpi7lZ0py5wKFqnkL0atgktUPOf8u9w7GXpYCo4c5woP7
         YgsETrTKcgZkrO2w45bFZbaFXoC8vwFXwLGSPVeX9oZkhKBWSFvw0If/V04LtHvU3V1K
         wtSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gpL66/D2iZNZJmKtmfPRZTI2dqc5FxpU7hvuG7+bRBg=;
        fh=7ZoPpuPsL0UGaj1+jjLGtmGqShAZjvFUDHyP0EBItSw=;
        b=Svuj09KfDXuyC/4doJ7ed77EnykeGkhh09rfn9rPP+GTjlNWd+dzuGNbIIeSmmYqmC
         +fCC/IR2lIkyM2+FnNZqHeBVQ3248iGqY9+iTI+I4mrh6+ghm6c7FWlqgC89kPlsuIJB
         NZrI8xO5/Lwv8LuuOg0o5KY7Cxy/hY6heyvzX/TNW+J0hSq6hn/iA/qzJCmVJAJGRQEw
         3zN7AIV9ke05pXmN7A3bwUkLOyMFjLmk7UmnSeUoFTrbjE5rLwu+SMPzbBQ1NnokfewR
         kYP+ugFT5Vh01xgqLQTlyCdU5ZEJxwnTgfdQUqJKozWlN79GgLIMOKDPEo+jhEKuskuv
         pGVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792618162; x=1793222962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gpL66/D2iZNZJmKtmfPRZTI2dqc5FxpU7hvuG7+bRBg=;
        b=ddppVnau0+i/FiKIfgHvrZQRXAmxdfxx8PlxpkElrZdLoxzaS1gSeCK+8z03SOX3hq
         9sHnRD87WNABg13m82RBK1ZB80FT7HMWo4bSRgOAXH4FSme21PoCBllqT/lqOP2BLYeB
         gbybtK71K6fFXzTYLkYtyxr4/WXt/8YRk/nxD1OBcFA56d4EwUBsBABubL6cj+7rC3pd
         QqRroE8VxkaaOc0i+6MFlUrUww99Oilqznya+mLiUZxfWmw6WazTCV0bYFvIC/XtZLyn
         AjmTxQDrtJ9MjxIdtx7tOWJ9Z56fKB0oAi140vpQp/sIMKupIQmB66felg+DResRkJcp
         SJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792618162; x=1793222962;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gpL66/D2iZNZJmKtmfPRZTI2dqc5FxpU7hvuG7+bRBg=;
        b=TWOtncVE0Gx9PJ9WT7JV20RZDvhlA7zOTBxP5Ym4ZZwXBejXQukrRFgf/DC9q5cJdd
         z0D4vUQHTPG4xtxYCStW5rJU09kdufhCDQyU+yUhJkTe+sKCan/mgqwfmJ4LPzLy6pck
         gjfbMBhvLUKiIswhb2gY3lW1mNJtKNxAmGxuN9zCZFaX2sG9dmTO3oVsZCF4isEY9xLV
         45i5JMwU440BHBILivPVv25aVjYEFgWN8ohMjJlLtrLHKvXP9KvaAMqom643oPv7sFIc
         UmJOusEikU4wBWAM3kPhYkRahnFTr7TXb3u1dXhbBXSeN3/vAVrgSEHFmWB5aihfvZMK
         IVtA==
X-Gm-Message-State: AFq9FYJPPvyH5UZERh7mmUyKi7+aVYtlXiM9wgqN9XkLy9ix6O5YVxHf
	NxE2yWiQEuT5NGyeRuBxVxeC105rfAhHDa6DwK0kpGa2AxhuyfJZlplzVnr3SmN9oWCAVuZSaEk
	q0/KW2WahXaUfxqV1gkgCqJ01mj5VhMo=
X-Gm-Gg: AYBFou2VzzfPqUxVyNIQOgQjS8dmvyOLsvYzrmrWMKP3UVUvw8pZ/5m9/mT/cYHcUCg
	wJmhw1pRXAzIwZJfDcS6jgHXC6QSsF6aazBQ0bsyAzI3Q/YIPdt/o7U0wVYUzVI/deS2ujdenDY
	uj5Nf4uj/l86K10VHu2ru/oRibKCpC9nNk3L6/AvWMUKkCaec5pk6MKoRRXTK2eXSXml9jfn0W7
	QqZqz7JBlAJfarrTvX93eZmemQMk+uF83sWZY8Dn0aRpQbJSewRrBNhSjKyAiQxKz0ZhuECEPB2
	ESfUpn4Ao6c90YMeEFh2ybw7Bnvvy6pwMt3pADCqtEKFA+7fjR6YcJvi6+aL+zwkyLF5cVctC2v
	2/mfKciEfSB5bB+a2ZBcM9PogRcIKi0s+T551
X-Received: by 2002:a05:6808:23c6:b0:4e5:79ec:5bf8 with SMTP id
 5614622812f47-55365bbcf59mr2745881b6e.67.1792618161769; Wed, 21 Oct 2026
 14:29:21 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021210754.3270023-1-xyx2021@mail.ustc.edu.cn> <20261021210754.3270023-2-xyx2021@mail.ustc.edu.cn>
In-Reply-To: <20261021210754.3270023-2-xyx2021@mail.ustc.edu.cn>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 21 Oct 2026 14:29:09 -0700
X-Gm-Features: AclHuK_TvRfFZ1LeeqVBqWmlEWUzjkCKd6_pPyknEI1L5nyqBM9kSLh65UBc3CY
Message-ID: <CAMB2axPFKQPGEOmSXK=0mKO=HBijS1JFV01r3M18ifqFBreFvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Track borrowed iterator results by default
To: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, puranjay@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 2:08=E2=80=AFPM Xu Yunxiang <xyx2021@mail.ustc.edu.=
cn> wrote:
>
> An open-coded iterator can return a struct pointer borrowed from its
> current element. The verifier has not tied such results to iterator
> state since the task_vma iterator was introduced, so a saved result
> can still be used after destroy. Commit bee9ef4a40a27 ("bpf: switch
> task_vma iterator from mmap_lock to per-VMA locks") also made next
> release the protection of the prior element. A later snapshot
> conversion made vm_file explicitly borrowed from that element.
>
> Associate non-RCU, non-acquired struct results with the iterator
> reference by default. Invalidate dependents before next forks its
> NULL and non-NULL paths, while retaining the iterator itself. Let
> destroy propagate child-reference errors. Add KF_ITER_RET_INDEPENDENT
> for results that outlive the current element, preserving existing
> RCU and acquired-reference rules.
>
> Trusted pointer field loads also need to preserve the source lifetime.
> Loading a trusted field does not acquire a reference to the pointed-to
> object. Set the field pointer's parent_id to the source's reference ID
> if the source is referenced, or inherit its parent_id if it is borrowed.
> This is a generic rule, including accesses unrelated to iterators. For
> example, the following access is now rejected:
>
>   file =3D bpf_get_task_exe_file(task);
>   if (!file)
>           return 0;
>   inode =3D file->f_inode;
>   bpf_put_file(file);
>   ino =3D inode->i_ino;
>
> The inode pointer borrows the file's lifetime. Releasing the acquired
> file reference removes that lifetime guarantee, so the verifier must
> invalidate the derived inode pointer as well. This does not imply that
> bpf_put_file() immediately frees the file or inode. Reading the inode
> while the file reference is held remains valid. Fields with independent
> RCU protection retain their existing lifetime rules.
>
> For an iterator result, the same propagation keeps trusted fields such
> as vm_file and f_inode tied to the current element. Propagate the backing
> object's lifetime through dynptr construction too, so its descendants
> remain in the invalidation graph. Reuse the reference-release traversal
> for next without releasing the iterator's own reference.
>
> Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs"=
)
> Suggested-by: Amery Hung <ameryhung@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>

Thanks for working on it.

Reviewed-by: Amery Hung <ameryhung@gmail.com>
