Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD2A137750
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 05:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785389624; cv=pass; b=X3EDwdO+hBTk40jCy/ZIrqg8b4Cl/H/O9OVsuRl5dj47+JE9nAElvM8hKwTGSiy3QVrbVeN66wb0ImVoCCPXbZRbcdbbcgTfrKRB+g7xcM7ThzHcyqhS8gdOj7aKCzgQlROH0ChaDqEak/bTF2dtQC0PlIpi4U1oowYAPRMj4rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785389624; c=relaxed/simple;
	bh=QAjtZGlsTI4ybwd/3YG8FRLVEHsjSSPZKbDGOzbL6Uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6tB3ysuceHKcB0LSDuKqmIG0lKRJl1V96Yv3HlTXC+00MOB3OI/XqYetSzf/BcvetSPB7mKOYZ77tg1H0+eP6VpSKu3ESb7F769TnUKrW1LKmPM/GiyrdMV+DdwQ+uwMqre48YT3+y7tfDjNR1Z+iya701GNDuT7YPb+bGDl6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qs49Uvoi; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qs49Uvoi"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81e69a2db34so27359377b3.0
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 22:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785389622; cv=none;
        d=google.com; s=arc-20260327;
        b=PqtfFfzjS264fGqqLVY9xDRoEgbMlmpoKXC6xCiVcoKgdzY3BTWjWaimkokDo1c4/K
         BDXqVuSGgIwdTMEZp5FYa1qI5QbnvDs9R7JMxzKV+SH9Br5X2LWHerxdPNHpZFYhGojM
         95G7vqc+v0Gf4XChx0Cssl/HUAtNfV8C1zLv7mctFBIVBpcjw8yjnK+qXSe3Pgsmt9cF
         HJNbPuXrV+ffdGAiu4P/H7Y5dCO8yGnHdpo7AZpH9JQ0a26DIJTk1d+gNhDIX5lbMdiF
         FsIOjH0w/tkuHp7N5df71cTqTYezWePj7L+v5LTtKIMA4qDGony7bb+wjOXo90/O4jst
         AG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aXv7+4L1zPUBJ0jHNw2yegCL8qijmMUxT2IRdJfetDA=;
        fh=6Z4J3xNs+qgwS2aK097++l2x6CIWkNCmJIKZe8W3oU4=;
        b=jhBkap+S1tIk++WuH+d6mRO3p5UMDe6Nxd0K8fZGLyeTIbljgYbEtu873e/xyRoRfe
         d5wv0ekFKCQ695ktFgg8GJnQkbtPyyt7mBw+T9BtT0JtRT1MQjVRH+PQxpnn3p27Hpks
         wsewM50I6as1+oMy3ztxsbPE6JE4eaWTJm60QJf1N7a7Cp6tmZPJ25E/csTsTV4tIuv+
         s1yZocMOxdHel1lRB9HtsXsbl2ILQbrjg9a4xpLl92kub6cIb7b14WH5Sztipu3jJQ34
         v2Sb6OPIwRykqqNzLE7zZA+WEPfVjy+Awd1CoSld1dHgW4OmZkU2fGZajVzAojuldx58
         nypA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785389622; x=1785994422; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aXv7+4L1zPUBJ0jHNw2yegCL8qijmMUxT2IRdJfetDA=;
        b=Qs49UvoiG7dBGkJL3QHnwnAMFhJSh2rSLyqANukVmYQEBOsBsoYcwzKPGuGwCyWhc2
         DGLx3+YV5v1z+0gkP9gkL/sIpYHhy7im+31YG7rE3qowjv+ewYPX1umrdLQl90RIv0LO
         cfe7rQBiJgbKMInwKj3TcK7XXYgf1d3OwP15NnwrdeZ+Wheyn+/adumlqhlobCaG9TAl
         biwuiJjFaiYu08sED0z2Z11PW9RaiNJS68GPCKfD8SboL0k+d36BSOrC+aVii73rHM7K
         pKxjupTVgZi8SOGKVFbrKbb4DNCyO/1+YAEAi3gQOFIhqOBR/jv73UK0h/TDBb2oIWIY
         m1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785389622; x=1785994422;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aXv7+4L1zPUBJ0jHNw2yegCL8qijmMUxT2IRdJfetDA=;
        b=m8yowFmXHBI4jYUMdCA+eC0CvfrhrVg+P3bFpxAsV24EB8YqBUAcyUWWKkfXJVukQ+
         LZLLldkgsQkQNqG36oJuYFBGx/1jyUiwE4T4RLQDpAnfqMBCzWtSYidpzqf9dA4+MEsQ
         EX29EhAwzjjTmVQRB7c6rlJVNhURSOYJ0/7Rjnaz05zyKQKt0NqKB4D4paYndAMINGg+
         eZ3aeb0TcRRhnYKHYJRTJRdDWOFhox5GKOg+1z+0S1sLsFUP9MHKWoMO9gdC/lHy4Kdn
         sjS7ADczrlUo2M2vtFhWmu/+yrbUDf0W3Gn9GR3NJfZgt1ZGdWFepdRvvOHime+3OxTh
         0nyQ==
X-Gm-Message-State: AOJu0YwbBK7qPSoo1kBgh+F5w63MDWJiNwWKLfBzHXRMSKlmEvi8mQ5N
	j8N4rSkdl1ijGe6NRC+fWPUqg9/b6s/ZbxrVwUcH2b1QjSaJKnSL0meM1DpohNLSwJQ1+JNUI3Q
	rOJBzMas+o/RlMBmVyArKgAGVKmLwKJE=
X-Gm-Gg: AR+sD13S2KLJWv0I3G+ON6ZSjkgiQDGPPVy64vYtjk0KyIAOe74imEL/CDpooI+93Dp
	6xLWnj6l9EZR7IRv9ZS+dD/G7jiJBs+30/wu/oWm6tnP30A++CGVkal9VKn4Co9VqjcNUYtHdql
	7XajlpE4QqPIofDvsdeCA1/f0xw/En3J4ShxsRp5V88cv5FIVvrwB69LBxHvqt5+7z3wCOAif2r
	GO/BJnoyMXVZ5gqJdvx3LukfN84c4+r0Q0N674HP4VOHP7y+8FXeBYKrR6roY7dUDafg2vgj7Xe
	wgGRqS8PkuUUJHzh4EtIEiLxjz/7pbFNYVjx3gql/d/W
X-Received: by 2002:a05:690c:6c0f:b0:7fd:ddb0:2622 with SMTP id
 00721157ae682-81fb88e3c60mr8450527b3.6.1785389622077; Wed, 29 Jul 2026
 22:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724190813.1458271-1-ameryhung@gmail.com> <20260724190813.1458271-6-ameryhung@gmail.com>
 <27739a12b7f7d5cd6e7fceeb389cff0072aefef2.camel@gmail.com>
 <CAMB2axPcdjVA6Pwp0TpGpMtJGiOB5khJ4HA13iJ9XT1qpyfNtw@mail.gmail.com> <933cbc8d75fddf0dd94a7ae8614a55e9dfc231e5.camel@gmail.com>
In-Reply-To: <933cbc8d75fddf0dd94a7ae8614a55e9dfc231e5.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 29 Jul 2026 22:33:31 -0700
X-Gm-Features: AUfX_myV950cAa6MzEhvc_q9VpdRy4kIYsRNRbkWt7ub8KZv2DTkabHP98a-N6o
Message-ID: <CAMB2axO=y6mauaS+xLVVYWUNByiK0+AECJmL-UpUQQFL5Rn8EA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 05/18] bpf: Check helper and kfunc mem+size
 arguments identically
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

[...]

> > >
> > > Note that the check_helper_mem_access() already calls base_type(mem_reg),
> > > so the '&= ~PTR_MAYBE_NULL' part is irrelevant, what matters are the
> > > following mutations:
> > > - PTR_TO_MAP_VALUE -> CONST_PTR_TO_MAP (plus it's uid, type, ptr)
> > > - BPF_MAP_TYPE_XSKMAP -> PTR_TO_XDP_SOCK
> > > - BPF_MAP_TYPE_SOCKMAP -> PTR_TO_SOCKET
> > > - BPF_MAP_TYPE_SOCKHASH -> PTR_TO_SOCKET
> > >
> > > A better design compared to current temporary fixup for a helper/kfunc
> > > call would be to deal with types CONST_PTR_TO_MAP | PTR_MAYBE_NULL,
> > > PTR_TO_XDP_SOCK | PTR_MAYBE_NULL etc, instantiated at map lookup.
> > > Wdyt?
> >
> > I agree that this is a better approach. This can be another follow-up
> > considering that this is an independent refactor and the size of the
> > current set.
>
> Hi Amery,
>
> The change appears small enough to include in the current patch-set.
> Here is the patch:
>
>   https://github.com/kernel-patches/bpf/commit/e59423209d66e71baa7c66e5cda3b2018fcf273a
>
> Wdyt?

It makes total sense to separate refinement from
mark_ptr_not_null_reg(). It is better than the stopgap I have. Do you
mind if I carry this as a part of this set?
