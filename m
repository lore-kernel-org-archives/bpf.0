Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE343F5BE4
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781730405; cv=pass; b=CQrn2n3ApoUjdJpYYnxw3EEkgvmVGE5JVJaS8DD+ZDUhG/LnHi2OnHxJ7obn3tfgZjhpd4qefJ9WuZHQEK6zXxmAckb2+f3rQ5YvrY8KCnQrn5s9AYXxfQnvNhY/EnX5Dm8CdIAB4ArIy9iHuWAxWKYComR2LeN+cyb4FHvTmQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781730405; c=relaxed/simple;
	bh=9zZbQ01sdGHuw/o33OWrkcBJ/OuWawGIIqbeIIAKBU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYuRATMJfViDQsL2/QQr4oHr4R/vc5opa/ggr4idJy8vcdyAGP0KO+EadonKwI8Xya6WIkXdbU6VovYLW9ljiqMBAfeqJ+jxj144hv9Ng3ogvqrYQVg6BttlVsQng64OCRCw7thl0G7HVRWfdURU8Kk4DuYyuRA4uE6iZ7/oXI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpPJc2RW; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpPJc2RW"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso179455a91.2
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 14:06:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781730404; cv=none;
        d=google.com; s=arc-20240605;
        b=i2dQ37riIS+RHx/JoqaTaMfDOPUj+B3/lJz8kbHWF3zbYWVDm8/oaRF6BMs9IBgMZG
         7h9RIKVmux9yFunaUz8pVlf2H6cr+sA7g3V3fg9VLG5YvOd/UnouqgtKG2hijlCyCK0q
         JiWuik5YdJG5wPVhKbK5MhTRdEuGTqCV8FUV8L+RSPurGGjBgTjHnGCSZ3aEgPY5wpSi
         dhPycoPBFCRqx8GtFMjpbHScafBGMLz46jSk0uiuh8od9UDhH0AKvrKkrzm0Q5F7boGS
         RGvhOl1qbqQXAqBRoH1KLD42CgPEZ4qlMMDS7bI5bWQPvG+c3Mm3WXfQKcNBShD8ogc9
         FgqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=np4Ad6HoqJslb4MIdJr2xIiKOz1hID1M1Fyl3DqqXZ0=;
        fh=2Bhn4L5v9Zj6bc/u5RNkUhNMd6q+aWFLx40BfRBKbnE=;
        b=dBw48k3Ja21MRILVPtVqDlPVN4JVuwHxyDH0osrb6FdWxmVPWY3Jh1KkwV53Vzf3T2
         5SOqNYgUXxwvSGNKl6aseQc4Ch5KjMfvCnMZQMEAPWp/l62AaaXQi+lFeD46WyonHScW
         BLe4tFMjUKY5eskdbvOCZGpX7YpPUJSDPbX1XovBAGX4ktqb4ITRIhr8Ikc045WmzLDG
         qiZfHKREjqz0+UI+hU6/EUyniPRswmYahzrHomoW0s5u2824BYnCrKacGlOaIQouR2iM
         sVtm/cjn2cEAiy5DS/outygfoXZlMohAnLcuGFVXqh82CvlRdhO1Y83AxZ/QD9ITKxsM
         XK8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781730404; x=1782335204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=np4Ad6HoqJslb4MIdJr2xIiKOz1hID1M1Fyl3DqqXZ0=;
        b=PpPJc2RWUW5ODz++bm2BzsM1gJswPh797+1oC2iux17CTckH2jEEXIDcA0zOigJ0i5
         9x+uKohIga7llWJLW23JhNEeLcRDHKDBstL9WIbW+rpLCwZbKGx+/AqjdzWjxmgiqHkt
         nvzQJOvE58GkYX44cLZNGmF/pzUWJbM1jruJ/mHKU3jtN6ueqO6KQXCod/Rc5RjUVgYs
         KngxScNYyfVsl13Jxx/c5fgO0zLm/3RmqUZ82B6KfMTTeOOTgfyY8zi9GRawkNYjDwrL
         iX2TfhGYhQan5tZod4rBbryFvZRULkYZcJ4tn+3zWmlWaSrsjmcRMUd7oHgIksd7wvav
         a1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781730404; x=1782335204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=np4Ad6HoqJslb4MIdJr2xIiKOz1hID1M1Fyl3DqqXZ0=;
        b=OgcAHVe5eKIHwcvuEPKZ9t53C3JrgLFZvfuM5bdffgl/SKf8uML82cGW0rns7LC7Kr
         UpBsEUFwKrWCpjrWtelWR1UxUR7cVwe/K+BpUbrMhObxUeiNeqKk/PL28T2rutg8FbTu
         sobqlTnxXvpWAH7q5D5bRtCiDZgjm1qq6w5AS6SK8MIDADyDQJ7qdYGCx3DddNCx/Yjg
         v49aUhLvjwxD74/v3xO//PFr7dVUV6mebMkHRnUYDrmiAVCYFZ2VP4wmBTJ+1zMRk5Is
         iIn/NXWIwR7MGtPLRHUn28xB8m9GSOcHZDmPaiyAvfAjTW/hHKjBDqcW+hGsJPP33Yq0
         3V2w==
X-Forwarded-Encrypted: i=1; AFNElJ+v8G+lhMvliiBvo+j/yQ29MCPC7O4qbxla7T7mnbS8L8QIUQoxqIOF+GCYnj+YkxxR1YI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXCt6RMrEKDKtPBrPQd1rttyPjTDHPG79sI1AqrMQ2c/+md78i
	0Qs58J7JbcuXEKeYmuy1wPtq5TloIo3U9xZHnle6v5UfZECple4JDaEehfI9VvL/tz1QFCScJLU
	X9Jo4H7WzDsTJQ/yMlto2rKQTca8MKHU=
X-Gm-Gg: AfdE7ckZCiZSb856Egv3PTcThC9S49IIbZOA2/yK+S7/RczeSpca4zjS634/sclMK1X
	tSM6akhRt2BuDYCHrLDuDlePHHCd1dD4SJpCv5NvOz2oGE77bL95bKJGo/i99ABsbfTWxZXh2zB
	FwFxwfkq3b1rw+ieGJLcL9yquqyaoL0ZrdBbXabfS+1Lqxq2EV834RH/ZAuFGgvlDksw/nsIoQa
	pAPHitlKvZCJINqsyr2YOvJKTyTdGpTW5fTIqLy4TNgFPGikBtMQfCP0cYb5xUZB1g6EFOHYLjv
	OcUymn4gcCDADDU3y3bLblS5BSfpslUx85JgigNNGipbINUm0Ub3SHYQPQCAyVrNPYyaDPjfH3X
	BTivKXPHl3ASodEg39Bh5AWUD
X-Received: by 2002:a17:90b:164e:b0:37c:6505:e7c3 with SMTP id
 98e67ed59e1d1-37c9ecff3aemr5523695a91.22.1781730403938; Wed, 17 Jun 2026
 14:06:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617202147.78347-1-jp.kobryn@linux.dev>
In-Reply-To: <20260617202147.78347-1-jp.kobryn@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 17 Jun 2026 14:06:31 -0700
X-Gm-Features: AVVi8Cd260eIQwhzGPEZLA2uVsQtbeQyANVfuu2LDFQ8_RZ7E4bOAvVo27OLPZo
Message-ID: <CAADnVQJ=q7hJkt=ekLD_a5KjJ_+icdwgsY61rujjLMKAKByvWw@mail.gmail.com>
Subject: Re: [PATCH] mm/bpf_memcontrol: mark BPF memcg kfuncs static
To: JP Kobryn <jp.kobryn@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 1:22=E2=80=AFPM JP Kobryn <jp.kobryn@linux.dev> wro=
te:
>
> The kfuncs in bpf_memcontrol.c are not called by in-kernel C code. They a=
re
> only referenced by BPF programs and resolved through BTF.
>
> Since no external linkage is needed, mark these functions static.
>
> Fixes: 5904db9891f8 ("mm: introduce BPF kfuncs to deal with memcg pointer=
s")
> Fixes: 5c7db3239c9f ("mm: introduce bpf_get_root_mem_cgroup() BPF kfunc")
> Fixes: 99430ab8b804 ("mm: introduce BPF kfuncs to access memcg statistics=
 and events")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202606150332.Xy4Egd9s-lkp@i=
ntel.com/
> Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>
> ---
>  mm/bpf_memcontrol.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49d7647..eff79bb2c758 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c
> @@ -20,7 +20,7 @@ __bpf_kfunc_start_defs();
>   *
>   * Return: A pointer to the root memory cgroup.
>   */
> -__bpf_kfunc struct mem_cgroup *bpf_get_root_mem_cgroup(void)
> +__bpf_kfunc static struct mem_cgroup *bpf_get_root_mem_cgroup(void)

sashiko disappoints. It couldn't notice that kfuncs should not be static.
We have few "__bpf_kfunc static" in net/ipv4/
that work by sort-of "luck", since their addresses are taken.

In general kfuncs cannot be declared static.

pw-bot: cr
