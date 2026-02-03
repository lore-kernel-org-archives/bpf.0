Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E60E2163B2
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 01:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770081263; cv=pass; b=Wtt3iRJ4fSPC4Zo53h5sXNYDJaDZ+4nPsO50ERQVV2GxpmUaUyrzr06yE+vokxOizlpeZCJmldqfpsqN654lsPifOi0GUy60y+iHNmqgtg3qQWOBjnw/QB5hOgHFFUIkL4iFJo5pfN65QPPT1KEuuKfuAXZOIkcKIl/2EY8oqwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770081263; c=relaxed/simple;
	bh=4/iLhpqFPP149Ves7/SHxvHdwNhFRg1JwgdXcRn/A/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAIslwfuxeqDgrx2lLdtUhxKbPQ6L1C0wQnUoTYDuVyRQ1pwXLea+MayLf2TGQYdsoJiU8eO+cOOyKYNVvbj26gnAcuGZGTL3Xw1Vymlkvc5RvMSc0TallAGLntcUxo8KMh0sqIdPc4XqnHgf7sZnQ6uLkGZgU4TjlL5wX6DUrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2A4m+Xa; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2A4m+Xa"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a79998d35aso34037095ad.0
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 17:14:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770081258; cv=none;
        d=google.com; s=arc-20240605;
        b=P0hG9SRxfztS3G4ny2Yb6Br9EOew+RfmHE3O34uSayg27Rrv1XbwzArV2eKx+t4hFa
         AjbVRc4GF2OZ5LvkDkN0xa3wg7GhGH48vBGySlMx0Drcyk2QITeJ1Zcc/6Qkw6Zkuwpp
         6GCIsA+UJfQP+K+VuVIrIAmNhnE5/n4Nyf7zqrYd+c56iAygefu2/wiEPKCmxn+dczsN
         4G1BdBeH0iMK5wu/CUNs9ZtNxUMeiqXJp1gwmAVi7Cf5xYP0Mdlfn+umAf1pr+8KCxWH
         3Mvv+wLKwxu0v4Gu0rCb573roQ2zv65tJf2lt2jyY0Lk7OVZxAZoUIP5fkKSOAO+Y13Q
         +EkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FDHOspxtTXi7BJNEKnz1JYnZxJzaJnXWmJwoN/Q1st4=;
        fh=xhHKHjlFV8yt6XOvZjZTN6cTKoSdLxCrpYFEJmbNYYA=;
        b=VyCrd+yUyg7fUoyuOMcWcA/A2Gk08e6gtgiReoYT5QZc/h2d0dbalIgZ7S6cgi7f9W
         YPQLv7fDXvYuJ6mxagfsFdCJRvMLM2TehGPeiBesezcznBrKIZzljN2j52B2L5VEtTwK
         mdduVepW0j4gmHoxik04p7H3PIzwcPC683d3oqvSIYp9/RlXBEHQHM7MD1oxuyja+LnF
         pn0xqop57lN2n/Cp5eP8Dj/85ytSYRQPhJp5Baob8pNBgX97dSeQjK/nC3vwA82BqE5N
         ZPVO3Dn3QsW6QMCGrlrARE8tWuhuLjSelASaQohRotmRPF5OKJtq8MgvtWhjLAGltFPr
         XLjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770081258; x=1770686058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDHOspxtTXi7BJNEKnz1JYnZxJzaJnXWmJwoN/Q1st4=;
        b=l2A4m+XaQQC2U2iYoLbdsI46B//ScRQ4mGnP4JKR6VvHvjHZ4b7Vgw/waxa98cODjc
         uXI7hdq9IeOYQetSgR/z9kE8LPm0LcguwbOZZzxQpD31KCQH8zBIhEYG4MboMfS3+YUv
         sTQ1j7GyjZodLIONNagA4u+qI8v1Hatite8eswyURca3zoXrJqgLtusMFKX5hxCixjJg
         QLKKk3MagwmzP5KZfAuwBPWMF8L2SeSoO5x7W/Vwa7Dj9Wkql7/UlOJ1uYZdUX0q7oHy
         TNJdgr7LccjwHBlB+t0xvrx26SuutDB3DklAbtM/x6NtMV4Uuj9vUFsaq3c2j9kr9koG
         MYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770081258; x=1770686058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FDHOspxtTXi7BJNEKnz1JYnZxJzaJnXWmJwoN/Q1st4=;
        b=KY9GgfQWmNNWak4qw9xGBsRQnjymBy/kmmFtols86bQxEJcqUQdU384voi+AgeAbVn
         Y3dN3ZqrU6JCtvWxAafdZHVGjnjngk+dTmDyr9dZTNv/EjmWiZ2O+YIENxEA4DwDQ8tV
         Unkjhzo8B1/o6lI8I95bVv4DY+XMZ8tFPRPyuauptIHqyo2eD5lJDlq7IJAwfdwuidPF
         I0dJvR9GsxFizAyX4gOMZB518XTQSJ+Ynd1p5dtW69UwIKYu0Mpm8gOs7710LVnbt0j3
         C9OydXQjxwivmSKi6fcHQ7jV2wXQKcMh/uGTeCoEb28IPg/THj4Y461dA/Fj4hMo4LxD
         3OTA==
X-Forwarded-Encrypted: i=1; AJvYcCW297jFMRRjrqB7Uf5osD/wYXPMr+Cbtu8HzBzk+9OuwPNbZGJcU/zmAkmbru/ZMsJvWT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0s5sNoeDkFH7zWn8j94fdZwdrBNuTHBqIelh5Oc1xKE5GMCo6
	jSolptbwF+ku+uFX/jA+2h2YowUZ4TYvrTjhmtPpJqchdkRXjm1bTqnOfhohVD4pHWiIoKlBFgc
	U38+5O9R5U/SyUiKv7tvRcy/5T5BpzmY=
X-Gm-Gg: AZuq6aIn6u6p15Y6E7J6CmQ3RzIZ61aqQGJob26sy0jkKe99FcVnIP4Z1oThqp+m5+C
	sDSQ/1vXtoUCl4+BRfKmTQDTfC1Uy+KNHryRp7IQylfAeUAgVMlu21GFqTPnDOD+c5mYY7VYAuY
	W9EkS3pknzC9T6IhgGQXMbMBCWm7a26rwKzxsoXy8crYnpGnY9VTuNhFOYY61dbChisqImjZMYR
	hpvGYacMm7999Arvj7ltakwLFhmygHgXQW3qupODgoeO6U5g6VReRTx17/d0Ir5oxTcbpngUGri
	ktdE
X-Received: by 2002:a17:903:2f8a:b0:2a9:db7:4471 with SMTP id
 d9443c01a7336-2a90db74772mr60140325ad.1.1770081258315; Mon, 02 Feb 2026
 17:14:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202090051.87802-1-pilgrimtao@gmail.com> <20260202090051.87802-2-pilgrimtao@gmail.com>
 <CAADnVQJPFANbYvYYyG3OQdXh4174bGwsamAzD8HZ5f=noS=BnQ@mail.gmail.com>
In-Reply-To: <CAADnVQJPFANbYvYYyG3OQdXh4174bGwsamAzD8HZ5f=noS=BnQ@mail.gmail.com>
From: Chengkaitao <pilgrimtao@gmail.com>
Date: Tue, 3 Feb 2026 09:14:07 +0800
X-Gm-Features: AZwV_Qgpw8kk5uHlki77i7O3NlEqEgTB_RP5p2AmJzKEvLsJy3Jf7MH58NnDq1Y
Message-ID: <CAAWJmAaiFAyK+PDLStoR_0sGAH6TeeekPMdOjhKwQ07rUm_oSA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] bpf/verifier: allow calling bpf_kptr_xchg while
 holding a lock
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Chengkaitao <chengkaitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 1:57=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Feb 2, 2026 at 1:01=E2=80=AFAM Chengkaitao <pilgrimtao@gmail.com>=
 wrote:
> >
> > From: Chengkaitao <chengkaitao@kylinos.cn>
> >
> > For the following scenario:
> > struct tree_node {
> >     struct bpf_rb_node node;
> >     struct request __kptr *req;
> >     u64 key;
> > };
> > struct bpf_rb_root tree_root __contains(tree_node, node);
> > struct bpf_spin_lock tree_lock;
> >
> > If we need to traverse all nodes in the rbtree, retrieve the __kptr
> > pointer from each node, and read kernel data from the referenced
> > object, using bpf_kptr_xchg appears unavoidable.
> >
> > This patch skips the BPF verifier checks for bpf_kptr_xchg when
> > called while holding a lock.
> >
> > Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
>
> You ignored earlier feedback. This is not ok.
>
It's my full name. Every region has its own customs and traditions,
so this isn't an essential change.

--=20
Yours,
Chengkaitao
