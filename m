Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A383914FB
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773333873; cv=pass; b=kua8mkzt5p6phAISQcqBMsX+3BfbUkzum4mQ5HQ6Dm7ZeCiU/m5Pg0qoy7xDoKUVgWQ2vsgRMxQU1InN1aIqPll27luhdOPe2sTG/QKplEHYEFQEARzn2e2tFtO3SzlGHmAiGlphel0vf8jBgERg4RXBvdQ8Tr7tJXX83THM/Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773333873; c=relaxed/simple;
	bh=rYPplxVjS/kmjl6Q2sAge6Jdp5lKZc/xVEfkRIgBvrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1DlOL2cG3NTJxrKofDru+i7aBe4SSRDm9fMZpzDg19bVJvHpvl9oPiwjb8X/3ya2xilZYEWwKSc0wtn6KcpB3R8y9A8XNIcWPEk0DB4rUOeZddHqh4f5HPTNdOYigBRWIqYlSo/A3BdQlQweSg993PzLtklVLFnx/h1VkjXXWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZT8NO8eg; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT8NO8eg"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35a1cc6e478so377950a91.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 09:44:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773333871; cv=none;
        d=google.com; s=arc-20240605;
        b=WUb75E+tP2K5scwh+wGDGVWKXnXnO9HZZDfwsRPPwadPkC0qn5flFDWiXjjgTb6qZV
         5u1Vpn/3sgTc60QEC0F00xUyNiywbs7kEstCk6rMjq/mZOytE/j8qDo4wegq6snBLLZk
         YgV6+T1KENv6W0d2uuG7JpexVpyLKoOiZ5fBOgcj36pGa5pbKgTBVy4LldqOCK6eoz7N
         kvmS/+/5AKNjOaALOgUGGt7ikRtGdEqX6aC78iW9IB3vNQ+dov0SxO/Mev0V2Fj/w1Hj
         txhiMNMJJhEDCg0NpZM7pMVMwFIn8SYu9kKUSf6/U/DxIQiY/0A4eZ/gSuwuU4sFJh+7
         pFFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hTDSiUymfqmwXMA8if5rI1/K91dzetC9FUcP1moyuxc=;
        fh=3JFULSt81QhP9ARgOVVWpn+UY1r04WcyvJhNnAO9JVY=;
        b=EXO3x7K1mYwX6arjXW1MUxBU6N+z4qP3Lyi4V6p3GNmVwgwhzgJjBgqBqh61SCQib9
         wXs2nkxCVMZvwBWqGJZM2VXiYPiw9M6oNM6cRTZrokv+YWcr1y7z1KfhfHux95O8JmZu
         B3MprDVKYhC5FyYb9JM/X3bUhQJxS2V8URDF1Y3Dckw29OXVw5GFER6ldNAIlfTk5Voi
         IGl44YDkJRf0djh+QjJ2fkIeYTNO+WpMjaCeizcKauyHeLy8vdsIniXTKrNG6iMJ9RRm
         FDQpfbf0LJ4dGgmpcRTlyDjBr2GAI74WJYFdq7aOYZKzl/jiFnOzR10BaFHClQwDMpZR
         Bb6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773333871; x=1773938671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTDSiUymfqmwXMA8if5rI1/K91dzetC9FUcP1moyuxc=;
        b=ZT8NO8egEdIfCCfM5IdY9xPLJa0fqoWXhVo4XnyX0bQQg3GC+qiw4t3TEVQw5FV5gf
         wU4tcy26GXiBH4S6JCYN6dytyktfalL9TcKzsTgePuoJzGp5LlK84d7aE6APzGjYN929
         VPZZZsJbUGUHxdfsOSqrNDC9Y1Hp7JVcBq3lqJWWk7ecvMRziJGmfURYo32onM/d8Pz8
         9g7VnmIruO3cwy/FXL/QBFyyfyb5lStLUGSXHINwS++35/i5WBpdxQ9uIBrXopR+6mCT
         MDE3GdAmXZ6N/U0F5RsIqSysdx0manrpCZuj0ctJiWHZ0srxRn/8wQF3mJ/U9YtwsOvN
         9Iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773333871; x=1773938671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hTDSiUymfqmwXMA8if5rI1/K91dzetC9FUcP1moyuxc=;
        b=kLksIxmlwdasV1rNzQksoefLNnM0b6RRiDf7gMqkjrBKI2XvYC4WbqHQPGAbJ6aOmX
         0Q0k2AcWa7/SPhpqEkpSF7iAwY9YMt2fc+0qN9Ct4ZpnmZrlUAurWCkiIxN6dw+CSZal
         iB1CFjDwD6dILFbNi6g4uugUmRUAOqcX2qJ/nukw9pzhGCdkiWHXt6KsKM/Pm/boMo1c
         uydGCrFDUMJxu40pobCN/jqaAeJYLSFBDCuGKNJfqixuBI2oRlLX7i8mSWyNkqEjAzks
         oVmSOWProNUshgaq58vF8rmH623poQ2+Y/J07d+w3o7R7wBLmziNpUba2PCMZSDOWIA+
         e/Vw==
X-Gm-Message-State: AOJu0Ywqpd8dkJ5K9PCEBC9kC/tDbvk0++1gZW3cetw6CvIn9JNz5/Tx
	PipiY324IBq6g+TYKrDEtfwbPI3WUMMvXpRtYUj5e1tyLBvN415jDu5zRK2Wi4bZhwhHQG+ACVQ
	FukxnlBR1swC8z5HbJyLDHh9foisZp+U=
X-Gm-Gg: ATEYQzwgBfJmkwtuyMKEwVVJ4POyJ8FK3BrWFFhW94v6rFZmvQmhrlllZinGPSNC0vb
	Px8/5ZjSv/8ZXt6/TClf/a52XEAhhEyubeTbYTmDlcDY/imUjYXKPZjkVobeQytD3TlSuAhoBCa
	o7NCAu+7bGK8HSH6bdLZSyxng3sA5BL9kSGTWYvA3LTMHuiqTvHMzFBTyyL2tjgd1yGxHC9eszd
	242rty4LaHftHg1pARfSAOs9tgsxXaQYn4ra9/N5H/baz3rStCdKAe7nmMs389Z/WRhRC40J/ZV
	Gy4v1in1yD3++UYHbFTCC/g=
X-Received: by 2002:a17:90b:3b46:b0:354:a57c:65db with SMTP id
 98e67ed59e1d1-35a220059a6mr253794a91.20.1773333871346; Thu, 12 Mar 2026
 09:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311225726.808332-1-puranjay@kernel.org> <20260311225726.808332-4-puranjay@kernel.org>
In-Reply-To: <20260311225726.808332-4-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Mar 2026 09:44:18 -0700
X-Gm-Features: AaiRm532Oatp4y9ODAwg7xfY6wyR4JU-W70mAQGeYgeOX-pRs5_Yp26IIVd93G4
Message-ID: <CAEf4BzYXpKh=6Bsme-=wv5CG=-X4uycgggJEF6UASiMgawej0w@mail.gmail.com>
Subject: Re: [PATCH bpf v3 3/3] bpf: return VMA snapshot from task_vma iterator
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 3:58=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> Holding the per-VMA lock across the BPF program body creates a lock
> ordering problem when helpers acquire locks that depend on mmap_lock:
>
>   vm_lock -> i_rwsem -> mmap_lock -> vm_lock
>
> Snapshot the VMA under the per-VMA lock in _next() via memcpy(), then
> drop the lock before returning. The BPF program accesses only the
> snapshot.
>
> The verifier only trusts vm_mm and vm_file pointers (see
> BTF_TYPE_SAFE_TRUSTED_OR_NULL in verifier.c). vm_file is reference-
> counted with get_file() under the lock and released via fput() on the
> next iteration or in _destroy(). vm_mm is set to the mm pointer held
> via mmget(). All other pointers are left as-is by memcpy() since the
> verifier treats them as untrusted.
>
> Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs"=
)
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/task_iter.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 50dbeaeafd86..83e3c3983341 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -799,7 +799,7 @@ const struct bpf_func_proto bpf_find_vma_proto =3D {
>  struct bpf_iter_task_vma_kern_data {
>         struct task_struct *task;
>         struct mm_struct *mm;
> -       struct vm_area_struct *locked_vma;
> +       struct vm_area_struct snapshot;
>         struct irq_work irq_work;
>         u64 next_addr;
>  };
> @@ -862,7 +862,7 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter=
_task_vma *it,
>                 goto err_cleanup_iter;
>         }
>
> -       kit->data->locked_vma =3D NULL;
> +       kit->data->snapshot.vm_file =3D NULL;
>         init_irq_work(&kit->data->irq_work, do_bpf_iter_mmput);
>         kit->data->next_addr =3D addr;
>         return 0;
> @@ -928,23 +928,37 @@ bpf_iter_task_vma_find_next(struct bpf_iter_task_vm=
a_kern_data *data)
>  __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_ite=
r_task_vma *it)
>  {
>         struct bpf_iter_task_vma_kern *kit =3D (void *)it;
> -       struct vm_area_struct *vma;
> +       struct vm_area_struct *snap, *vma;
>
>         if (!kit->data) /* bpf_iter_task_vma_new failed */
>                 return NULL;
>
> -       if (kit->data->locked_vma) {
> -               vma_end_read(kit->data->locked_vma);
> -               kit->data->locked_vma =3D NULL;
> +       snap =3D &kit->data->snapshot;
> +
> +       if (snap->vm_file) {
> +               fput(snap->vm_file);
> +               snap->vm_file =3D NULL;
>         }
>
>         vma =3D bpf_iter_task_vma_find_next(kit->data);
>         if (!vma)
>                 return NULL;
>
> -       kit->data->locked_vma =3D vma;
> +       memcpy(snap, vma, sizeof(*snap));
> +
> +       /*
> +        * The verifier only trusts vm_mm and vm_file (see
> +        * BTF_TYPE_SAFE_TRUSTED_OR_NULL in verifier.c). Take a reference
> +        * on vm_file; set vm_mm to the mm held via mmget(). All other
> +        * pointers are untrusted by the verifier and left as-is.
> +        */
> +       if (snap->vm_file)
> +               get_file(snap->vm_file);
> +       snap->vm_mm =3D kit->data->mm;

ummm... why? you were making a copy while VMA was locked. If you are
afraid that VMA was moved to a different mm_struct, we should detect
and retry instead of overwriting snapshot's mm, no?

> +
>         kit->data->next_addr =3D vma->vm_end;
> -       return vma;
> +       vma_end_read(vma);
> +       return snap;
>  }
>
>  __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
> @@ -952,8 +966,8 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf=
_iter_task_vma *it)
>         struct bpf_iter_task_vma_kern *kit =3D (void *)it;
>
>         if (kit->data) {
> -               if (kit->data->locked_vma)
> -                       vma_end_read(kit->data->locked_vma);
> +               if (kit->data->snapshot.vm_file)
> +                       fput(kit->data->snapshot.vm_file);
>                 put_task_struct(kit->data->task);
>                 /*
>                  * mmput_async() -> schedule_work() -> __queue_work()
> --
> 2.52.0
>
