Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD7839FCD7
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 03:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791947359; cv=pass; b=iensWAlk6mRkc2GebiYFDPWOAmwIEQyPCKNBp2jssyP6oniVwonY2C5tvPsKN01BrLTHjlirU4jy93XCQYRfsu7Z1OFVELBfgD12eXWUCqAPrGOMsJwTwdjN2qEBM8htCIcv6bozXDhoEZ7MK69GG07JBd2sayyTksxMj9xoIAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791947359; c=relaxed/simple;
	bh=UNzD/AxLjGFxfGGazPPzQZUu4rGnvyDIVYkhQgQITf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imTfsRwJS2UVHq6aqIEdFaU6wr+P9k1YCSz9w16hLmHDHoPnu82NfwAynMViNth/hRmtq/7A0UAkfXQ4iZunjJYI5tzbD2H17z/sVl8t0QMInMD2hjQZR2Tv5Ed1Z1EM4956NbieVO/1monVsYcsjw5FcLm5GrLK9lJAOIs77jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qEZI13k7; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEZI13k7"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6798eb0d13fso54240d50.0
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 20:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791947357; cv=none;
        d=google.com; s=arc-20260327;
        b=Y3XUSt15SPJNrmSAxY5OrtJzwFp1ClHJhvZWBh7iysIGj0nHP/5dCmBJ8G6X50LuT+
         SRPBuSZGEkX6Vj1vBfgEuKnf6FdNALav6huOmt8ifBYxO2Y6GZ3Gg7v45ALGpdg7hH8+
         +TrKIAzwmdH8i4gC4JCcQPRLer9Xfn+2f2yHqabGsEANrxtIvM+78UdOwDnKX9pmdkOv
         FUvxoXIcamdGK4ekC0/q2woan9BCJtrOXzd9Jy9WvFfvYSx/PKwhyagJUHFTqh2aFvqL
         RnKLS3b+TC1JhUPgMMf9jNlOpMF4vDYDaS2E6muwvN5zTbH0gScSPZAc1lurTfvQ6uTQ
         2E9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DZxFoqnlOiUWhIXdGMf7+RiabdBM+98/BuYUZOMYxiQ=;
        fh=3cv3j1edU4lOaD9/50gLp0B933pt+AxenepqMWigES0=;
        b=P6tKbHapzMfk8u3tS8FkfDiTMgvubTRWw5BVusSC2gbdQBNOiBKFGq4iBbUhBZh89E
         k7zV1L+NJkQz7+mkT2FmsOuqRL4uEPi1TBpFo2frJXfdN7xAtKwfu6/cjVnkH82fa0W5
         b2EFM/vxpwzgNZHRF4/10p83YdZlOkCcnpsOY+W8RSAypxElmPHSjqV6RCqsot8G0yKi
         BR/0aHLTJtxn6jMJpO7zaUTMklwHAceeCONnVVwPUY+w+biKi7bI3Jd54betgJT7kWbr
         AmDbB2TqJh6EW5hZNt3ZvXI50IiHe8TTvys70dhiqZhQAwqJ0JoZoswhJX2jKwaC84Vr
         uLdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791947357; x=1792552157; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DZxFoqnlOiUWhIXdGMf7+RiabdBM+98/BuYUZOMYxiQ=;
        b=qEZI13k7NC9P70Fjm9WImmKHlfni6bFYESVq2eg0z0iPN0Y8YcqU3ahaxWrB2Ye6Kb
         d9a4m1Nt7frmFghIYkLLtVP9rkmvEiYnReZl7tJ68i6bmwlohcbGoJkCLqimvmiQQgcv
         khTUR5qEdvYzmckMVc/wg5HmF4y5jTYN/h/ZT3slr8DAxWxY8uC+e8ajQiFsZo5AJlaH
         5gvGdnG0vOo9A0ExiLUUuZ4sRJMDr34phw16Wo2yonDRZ+G+DgdOFEuAVcMlmDBnXDZM
         BgUdEpCqQucPtFNO83HhoyJpm30qjPnIhQ9ZYAyhESEg1sZW8nw02QdToOpIB8fEghnP
         5uZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791947357; x=1792552157;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DZxFoqnlOiUWhIXdGMf7+RiabdBM+98/BuYUZOMYxiQ=;
        b=hajWL94PyQ6WqzgN59/G1+yD/CzsCXPo6wZhyD6jE07TzOYiXL/vcUkopBOs4Byi4B
         xIR/9AzYKruPWkcJb0P4d7bCAX0xvJArFg+3y6nV/RmTJANFvPFzzsuh8prE7mM0vhdw
         SlJi3Tl/ufHFK5hDWx8h0GGkHEbeLG+ufyL8Zo7dzyHZa8p8p3j+5cm8Jf2+8lt57/i8
         MVGy1zEhdWLY2KA3CHgPVx//vKVJS64bZK6UskEt/PfvRBy6Jo4BElRcBhK4ZCIpm0cz
         M7TAz1Rj9AdCYND429OWpHTj5B4zTwbMthfTjJLnm5xkV//vEqf0Qk+MTtobJYcnct/0
         tNLA==
X-Forwarded-Encrypted: i=1; AKwUvBy2tFySEFxcMzhMCmoECD4C55GA7OQHW0aZ1IhdltC0F8NRkthdettbChfGnMmEurUEeYE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUpihsPChry3PXm921YgPlgdvDiJLoYAC8GQn7PlcdU3LuCuSy
	S5YROLqS916DzJtvajt/IyX5H8mVlHxWdnacE9sjZvsP4XGx4IyRbltfbvo77nKqJe5aqgAHsMQ
	qBgdIEzbBO4+HLKHdruMLp7y4Xq1JU3E=
X-Gm-Gg: AYBFou2CPPUOpxOs+77/fLs4MHgb4H/XyAetAkLPcaSvvjTsu34xUpb27843Cg1oV62
	3+X8jzu9Oo7x6d1d3PjUHF3LLZb2AcDb1LntBKbK8k95E4O6C//vZ4dRTxSzwsxSQJ8iwTxhYc7
	dpxD6DiqvPOGTEgEnbIOG3ZqSkhuvN0I2kG9dloNdb9QJaqLHNpbjMGwCVqNsNMbQS9QMSFxgpj
	HY6vULCplweLfBhJMEKTTry0x2vFvrIsXNt5oSgK/9cthv6NrSTTj6IbZ68SM26+vuwyzT4B9ll
	ptDi8o0ysR5x+Aseq0eNsvsAqcvjXzHyNHMBEf/EIwAhgGk2Tkt+woKUhBwwkksjLNoH46Ismpr
	LGjA8FXhGww==
X-Received: by 2002:a05:690e:1913:b0:676:e85e:5ec with SMTP id
 956f58d0204a3-67975b9e0fbmr1610555d50.139.1791947356910; Tue, 13 Oct 2026
 20:09:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012120438.52849-1-laoar.shao@gmail.com> <as5RFhW1Ch8ta5nZ@gourry-fedora-PF4VCD3F>
In-Reply-To: <as5RFhW1Ch8ta5nZ@gourry-fedora-PF4VCD3F>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 14 Oct 2026 11:08:40 +0800
X-Gm-Features: AclHuK-Cs4-tIw-JWscmzRL89aJpa2RhvKqogcNm_f37Lr6_J9191jM_ZK2WR2Y
Message-ID: <CALOAHbCOTSOPTzoSqKoBJZ56o0pfW_dGQ7ZM_e1jT9N16z3VPQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] BPF-based per-cgroup NUMA balancing mode selection
To: Gregory Price <gourry@gourry.net>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, akpm@linux-foundation.org, 
	david@kernel.org, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, 
	shakeel.butt@linux.dev, roman.gushchin@linux.dev, yu.c.chen@intel.com, 
	zhao1.liu@intel.com, bpf@vger.kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 11:49=E2=80=AFPM Gregory Price <gourry@gourry.net> =
wrote:
>
> On Mon, Oct 12, 2026 at 08:04:35PM +0800, Yafang Shao wrote:
> > The Problem
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > In our large fleet of Kubernetes-managed servers, NUMA balancing has
> > been historically disabled globally on each server. With the increasing
> > deployment of multi-socket AMD EPYC servers, cross-NUMA access has
> > become a critical performance issue, which made us reconsider.
> >
> > Enabling NUMA balancing globally is still not acceptable: it increases
> > the overall system overhead and can introduce latency spikes for
> > latency-sensitive workloads. What we need is to choose per workload
> > whether NUMA balancing runs at all, and which mode it runs in. A
> > latency-sensitive service may want the scheduler's NUMA statistics
> > without tiering's promotion machinery, while a batch service wants its
> > PMEM-resident memory promoted when hot without paying for
> > scheduler-driven migration. No single global switch serves both.
>
> Have you tested with recent fixes?  NUMA balancing has been broken for a
> few years now (starvation issues causing VMAs to never be scanned,
> east-west filters causing south->north promotions to be skipped, shmem
> being entirely exempt, others).
>
> https://lore.kernel.org/linux-mm/20260629163337.1264881-1-hannes@cmpxchg.=
org/
> https://lore.kernel.org/linux-mm/20260930112206.205083-1-gourry@gourry.ne=
t/

Thanks for sharing these.

These look different from the latency spikes we've seen on our
production servers =E2=80=94 ours occurred with NUMA balancing in normal mo=
de
=E2=80=94 though I haven't yet figured out whether ours is shmem-related.
Given its problematic history, it's hard for us to re-enable it in
production globally. That said, I'll try to backport the fixes above
to our internal kernel.

>
> I also concur with Tejun that ops seems like overkill for this feature,
> this seems like something that can already be managed.

Tejun also suggested starting with a smaller kfunc rather than the
heavyweight struct_ops, in a separate mailing list thread. I agree
that this would be a good starting point.

>
> For example, why not add a new numa balancing mode bit that says
> "enabled but only for explicitly opted in tasks" and then ignore the
> global default mempolicy, e.g.:
>
>   if (numab_mode & NUMA_BALANCING_OPT_IN &&
>       mpol !=3D default &&
>       mpol.flags & MPOL_F_NUMA_BALANCING)
>       /* do balancing */

Another option would be to add a cgroup::numab_mode field (without
exposing a cgroupfs interface file for now) to implement per-cgroup
numab mode. I will think it over, considering both your suggestion and
Tejun's.


--
Regards
Yafang
