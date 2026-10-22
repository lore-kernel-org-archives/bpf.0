Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792694562;
	b=rLKF4tQkC3hAbnm1upVPHauLlvwPCNWamAQPAd/BUWfokdwU0DxVsvueL/O/vLTN7iHu
	 rDApH+CWEPJcTyauDKNqSRjOYUxvBIagvCCeuI11SI4eFrKRks5M+pGyhMz3WEnl+rc/g
	 POcfs/yXdPWf0ohb2zwbWZCYPKktXkzFKuS7Lhzypcp1PK/TCgzCl/Pu+hhm1XOyyt4fm
	 NLhLLB7oCoUAMfVCkd9y862VFmGcsRUySljHT6FoF8W2Yu+Gh+60xWPPWvmzoalB4gpj6
	 yfQVA1/gFd7kYYaEkD0I6zofPrXf3alFkea2I1dz6jQl3bCkKW+xeGHgDdPZ9FCXLzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=IZ/uBrhQVS3DiMAnoAWQ1amBgCkO8xqm7sNIOjhR87M=;
	b=KFjT1I7jxTM4sMBiA0B9x7YDbIjuIzls6Q3BoWDjOvnBuqStHxZi77ajL2U/ETSuAwWq
	 BWueodV6i6Zxg69D5/u6tx0x6Y95e0/qeuWACphWOl7xPR1ee4L1NBMwVvTueCZU+rY/E
	 P4x9gFSv+b3b+qYtTvtNC7QolKfroE5fzsLwOBJmJhsZX2zjPSjWIZ0/5uvyLxBDPE/Cu
	 F4rSPecmE6ZxYlcmOr9QVRQZNHfhtU/Ma5Vnoqkz6APBx0FhCY1SU1bH6ixxoN2t6nEu0
	 +ahT+UJPWvYy0jEc7zzq2A3Ve09fywvkkd7uuF0U7mlRZDlRlIGwh7YVnwoRj9UrNWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=AjYjOo95;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FC0606A31F
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 18:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49FC0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=AjYjOo95
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so7445ad.1
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 11:42:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792694560; cv=none;
        d=google.com; s=arc-20260327;
        b=TgeeNqYFrBmfw+bsk2dIHpAqilFVMH4BdfB5vHcavek7oUqmWXDZT7qsKa3rRCY6Ie
         1SRzlOnnqdDTsJTej9g971H9hCB2aRRQsCeGmXBgEoM7purWB6Rr9+S9/J/lT90EXzU+
         yX/inlu6Psj31TeFWZNMfSmrqbwm25bVbfvg3aYfMeci+yKIYgjESl7eRvJ8vXm+Dwxf
         cjmHBV95gkRGqKAu4kFwp85uvm1p6Mryao+3DjGmQYIAc9wxzmpXxlFS/PrZFyZnWANh
         KLnNk3wCkepKXo9FvCFtzgGiPxpK4LZdZFqSm/P4B0GknOqcL/U2mWpivwiiwuWckdAk
         GGmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IZ/uBrhQVS3DiMAnoAWQ1amBgCkO8xqm7sNIOjhR87M=;
        fh=QoMrEq6XletH3C2S5RrDbidyVx80x/3ec/ucaFrBVr0=;
        b=LxQz5AvBEylTV8GiYrbkXTMzX81af5QmyhhHxh3ftqGA35LJnf/5PPE8pHRlnVMwr6
         +4IvcQJ6vTocPIstFgFpHZewwheMjxEUDAtg8ZBKYwW/R5zOzmMLxHfoxj7AF1eRU3aG
         VUWetRoDX+efdY3DJA5xvp1fm1oGZXivW2HipDTmj5kTUImQFjc5R0c/XbMJ4w7i6/Su
         x/HplsYocYQSeUfYDjJEZENXEadpb5Slqx9+jhS2ptfio3JMAJaen31cp0rV0y+dF9ck
         Uxf29N76G3//rLs32j/85PGNPXNzz+si+8ht0fFyr1sSvas1q2oV1oW1VrDKG9/Hq1x+
         kxWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792694560; x=1793299360; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IZ/uBrhQVS3DiMAnoAWQ1amBgCkO8xqm7sNIOjhR87M=;
        b=AjYjOo95jj9xl9uSAdDzx0lnWrtlNBZWVfl9eonPSAZ/h1lQzGvwFUWLmI5y9N7++6
         nFHrpq9j6kdMPdO23m1pe8o+I6ytXCHDxTlI75nRCMiXl8D9WwnwLSQoHBx/3gkP+eQ9
         Ub0l1IrPaRGKNw6Z76jwymKiHpDfTwUMY77wsCTYQut7XKep0Chvd9qwb3Ote/0nFNO+
         uD5SL9oRjLepnNBGR9QKeEhpLzGIFu22sRP0R0131eZyl8P6yi1s+z1RyKaxiSHEHR+w
         aaXEbbLI49NZveiQ+EXzb40nSZWe/kGH9H9Tv68s8wOUdG5ZeQ1DxPSxJRGSIijkeX6G
         P7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792694560; x=1793299360;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IZ/uBrhQVS3DiMAnoAWQ1amBgCkO8xqm7sNIOjhR87M=;
        b=i2FlKlTd7uRoeSqoSOeD00WrU6LLY5kFiYo9IuADqIwJHDhjHLFewoRpt3AklXea4V
         VXWtCynwFyp9iToDXjxg3ikrWHjCsP3wU9bHc3IXnTJRU+q/j7rmKdcOeJ+sn95hNj+W
         /imzmYa5WSEU+IAqkDAy8lm3lR5Skojw02y2a/RxNVWgFdssRvOORFKFp1ZMovjcq8am
         1hER9s7SQ/FezKoisCMii5fG/tAlfid/piHIpzLuuipdhh51DXfMW0OHfedLmuZVtgcY
         H0abHR1I4yqgmAbDNuEvd80MqIExWn9Wc2zFPbijD6uEmDiXzqrzPOFBzY+bFcC9VMeJ
         tZkA==
X-Gm-Message-State: AFq9FYI6U7rNrZSzcJlQRKJYnv/aa8FdIVa5P/D6jcg4Btndc6WNYHpC
	JmOkHLJqekPIsmyBpmLZZZKptgfitt4DSGnXBQMRzjvI3XlamWlGyETc8MxvQIT4uYRfHaLjPyx
	A0UWLzTfncsRiPhi9Ngf3WjPqCJAhkyK8Ivr7JdPF
X-Gm-Gg: AYBFou1oU4naZbKHCP6R8Jf/VQETzJmBE+0zvQArsU9d0Sirk4Xefm08qJ7egiz1XHO
	w733PiVaOp3YQjl0lhPjD6cvKql6ZfeTNUWpg6QCOYSJ+xHJq7qoLtNw6sZqfbM7RjcrTMBTLoD
	zs83m3J/M5/yDzogYY0Zms1ff8n9rp+5WZw0KLn+mhQHpJvd4ieUu75ROPNtgGZU7mcm4mMFa1J
	qBMf1WGcK+EaCEzdFe4icftLEFDsaqOquAh7igfAY9ixKnmlrYvI3HYQBBJHvnzJnWAaNIMoe2S
	Ki3azwxfd+5srAoWouiPJV3CnePIc26o/pLQpVeVhnsRrWsLwZ9RREJc6TslIAiwvcowJMB5JU8
	1aeFxE5UbpFSJZqW2QSyXSovjfKo4uzfSOYxiuODGHiP4+nC1pEJl3qu0wEQWUkFE4dkHZa5J8V
	ZRKBPhk0QrkpGO1ncU5A/WPWgvz69Gyq0TMFQ2+Fxu4/Q=
X-Received: by 2002:a17:903:98f:b0:2e6:12af:5b04 with SMTP id
 d9443c01a7336-2ea7c74bcb0mr574065ad.0.1792694560033; Thu, 22 Oct 2026
 11:42:40 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com> <20261022015712.1297331-7-alexei.starovoitov@gmail.com>
In-Reply-To: <20261022015712.1297331-7-alexei.starovoitov@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 22 Oct 2026 20:42:03 +0200
X-Gm-Features: AclHuK-4emBvKnbiUXwxsP0RzswCumffVqYk-pDdBlhbp7tQ8eLavk3E__t9lUU
Message-ID: <CAG48ez28oYxMAxJaXnYtT_8xGReS6SLC5vURw4eStWpuPsSSdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/9] uprobes: Don't sleep on mmap_lock with
 dup_mmap_sem held in dup_mmap()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, peterz@infradead.org, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, oleg@redhat.com, mhiramat@kernel.org, 
	jolsa@kernel.org, akpm@linux-foundation.org, liam@infradead.org, 
	ljs@kernel.org, surenb@google.com, david@kernel.org, vbabka@kernel.org, 
	hughd@google.com, kees@kernel.org, tglx@kernel.org, x86@kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 3:57=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> @@ -1713,8 +1713,22 @@ __latent_entropy int dup_mmap(struct mm_struct *mm=
, struct mm_struct *oldmm)
>         LIST_HEAD(uf);
>         VMA_ITERATOR(vmi, mm, 0);
>
> -       if (mmap_write_lock_killable(oldmm))
> -               return -EINTR;
> +       /*
> +        * Take mmap_lock of oldmm and dup_mmap_sem of uprobes.
> +        * Don't sleep on one of them while holding the other.
> +        */
> +       for (;;) {
> +               if (mmap_write_lock_killable(oldmm))
> +                       return -EINTR;
> +               if (uprobe_try_start_dup_mmap())
> +                       break;
> +               mmap_write_unlock(oldmm);
> +
> +               uprobe_start_dup_mmap();
> +               if (mmap_write_trylock(oldmm))
> +                       break;
> +               uprobe_end_dup_mmap();
> +       }

I guess in practice that probably works fine, though in theory this
locking pattern could potentially lead to livelock?

Like, if two threads T1/T2 both try to acquire the locks L1 and L2
with this pattern, you could get something like:

Thread 2: lock L1
Thread 2: trylock L2 [fails due to contention by a third thread]
Thread 2: unlock L1

Thread 1: lock L1
Thread 2: lock L2
Thread 1: trylock L2 fails
Thread 2: trylock L1 fails
Thread 1: unlock L1
Thread 2: unlock L2

Thread 1: lock L2
Thread 2: lock L1
Thread 1: trylock L1 fails
Thread 2: trylock L2 fails
Thread 1: unlock L2
Thread 2: unlock L1
... and so on

In practice, it's probably fine as long as SMP cores don't run in
perfect lockstep...
