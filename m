Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7950440DFC3
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 00:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773880327; cv=pass; b=qIO1XlLAqhyPh7ID1zggQ6wZkWrTCwRe7SJYHS4bA9wasXFmgEdgSD1huHOlT9W+3ntVur06u7jF7PefnHA68dG5hTA0rgj0HRHJDAw7eDKzKA4ktgNDycegs6sIbvPgJ+Iz+qTwB/bYeoI3WI7TYI2Lle/+8o/U46p1CwFXsPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773880327; c=relaxed/simple;
	bh=au1TegqTXCC9cfCVAn8NRpwgSZFcAzN1jmv2uUT7u64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQ1xANv217igX6qvVqdFR7/lz8m0Qiwp6caCJWDdz+OY0Vyk9C4tk0tkCb5wrY6+oON2L1i05DffeDXCQOmrDMSS+S1hSwZcF41QbVL4CyYq7+wsayBwBcpFbuXUJdN9Qyaam0IvI+Vogut8wTDYKfdyHBdE/t4a+6CetKeb7vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLM6ZUo0; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLM6ZUo0"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-439c9bdc1eeso78176f8f.3
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 17:32:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773880325; cv=none;
        d=google.com; s=arc-20240605;
        b=ZvfMUYRIZjFJ521bch5fFN1BB6x6Eki1J4AZmv/EyopFSM8847jkVuqS5+0ZUdkg5N
         P9rZoLZneK4fueBQmWqMEv1pBy9945ov/q/0rY7AYqaMgm0KCGgQieOi1R2kvyKxYkt5
         1seCXqEl2wwU1Z2c6+eHQ0pCEc/z2+ss3GbVItIljgQn1pq3Po6QUKg+uvaUracna6mf
         hSH0cKMCFFpgqczi2lo1lwo5hv2nB0T7hrSuHkx3w6R+cmqCJIVdk+CVajrSG2x0jnn9
         FQMKCcxbueTgY+B0II7fyrRaCnq+w1jZhKA9XvBuhIEb42GzjwkCeTI+cS8O6+9Ss/RN
         H3Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jg1S09FOG+fgLkMLPk1Yja2qR3uqBz2sLBpgg4FPC0w=;
        fh=46zZG28lTtTsWFWzYGI6lyvOIR0es8iUCb0Tz4k17Xk=;
        b=XSUZ7VeNeHYvbwjm9DQn6Ikeim8iHROvoJq/OFf5NaYGjIY/GCjyuJNSQMifQ8zKBX
         K++GFQtSc9ut8fg9Hf9b07k9a7Xj+qVCj5pSFLcn5RPX0PaXo4Qx74YYOtQpRf75fkSd
         ZrcnSbwtXTBikiaFdUl+fPQZCZ3aV65Bb99X+KmQP7e0moFtt2LG50nZmDw06F/g107z
         6EDbOxJAsy6wEzqJEK5c/yYfZzRp286xvW8s7Bj4XZC1QZqMP8lLOMcVo84lggo3eY47
         4sBl/Ye09RLKe/B5DkxwtZ/eALQZ3we4I49XsCSNEwVl1P8ibSpXPG/kBv9rklOjx5av
         MIbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773880325; x=1774485125; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jg1S09FOG+fgLkMLPk1Yja2qR3uqBz2sLBpgg4FPC0w=;
        b=cLM6ZUo0i+0+M/0lA/fVYp4tiYiaAQzsSBGedfnk9zm06eGrcWGGFGIEF1fLjl2pm2
         ImJDreJ18ZmU+IwkBIzyHT4YbEXGAEsogmHVGVooyIH47x4IzjwQzTh2XDi+mn8i23Jb
         IQzyBpPWXtW9R7CWZpRv+sBOaQdatsni2pzyPuq59++AXf9B+MIpOHN5dm18/5Pflp9z
         zoewKiqVY/OacF9EwImKcN4z9LmGEmAfanPOl1GVhqORoZm9XCl6BvhfV4uDCfTWvmWB
         1qgx/sHjaYd59m4rMtMZZ5a+DH6o+CwuKwb5tPvkSMUJdh8ykCjENF2lB7O1Qgs3YXFk
         1cCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773880325; x=1774485125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jg1S09FOG+fgLkMLPk1Yja2qR3uqBz2sLBpgg4FPC0w=;
        b=XLzCI6oDGNTnC+JZflYllQ6AXdopeO57oW8EgPC9VbBHBYJ2JrL9h+hodaaAwrhEV1
         IRdqXWFqzM4AzYW7kJcqLKD+eMfJvBE0sIC7jVYOPh2tGewHMAeysaLxCRdWrs1A/7eJ
         RivNpM34VdNJC4mtsAg3hho8VS57718LWSWWfgat75mY/S84j+HOPCh90AWEHsWJ8tuo
         /jNKH8/EvWNN6t6pB8me/YngUBVLcJwt89yIdE/ZCLJj3K9h9dGIxZVoBxplhCWEAlz/
         FW/9XiYOarLVoYRAYTyEzVBMFZR/Q+x6kR4WFWV6UkO99Do1z+jyXBf9DrtlZ7YZu7O5
         3a4g==
X-Gm-Message-State: AOJu0Yy71N82Yup1lIYiNzUV0h5dcRd/Q3AE8yHlQYVs56UqbzwombS2
	YGUKlvMSx75T4+F3E5eeLmSqRVu0or7yWMePrhZbq5PtfdRLlktIHrez3/nBiuH4xl4MFk4SPny
	vg+XZTShIxKE9DeinUVYVlH6qbKHm8/A=
X-Gm-Gg: ATEYQzyYGOaMbjZLnWrxNDp53xhHL71t2WQnM/li66GqmozDT787fn6b71aGuxedHyz
	PrTgTGOn5HwXT0Z+MPfYSN4YX2GS3dLDy57y5AW3rOB2LN9AvsLClRIOqIhYwmgISiu5VB3e3xN
	5asheTtutNsgK3l8OWeLEXa0Ki1U4cINSvhqxy2+ucjzoPMqLmwSwucx6bGRCM82dL5iPTbXQCU
	3qbUQEC9Gs0DDC2Jh00oFDLeCay9EnPS1h8TEBKLVANL8LyAzJADA9UPCt8OIdkvCRJvGd2DCTD
	3khJUUAPegS0k7qz7dZsvXGzluPypgGxsfZtR2kjRmtP/xqRPrcow6KcMHQ=
X-Received: by 2002:a05:6000:2507:b0:439:c9dd:cd5f with SMTP id
 ffacd0b85a97d-43b527a7674mr9600630f8f.19.1773880324458; Wed, 18 Mar 2026
 17:32:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318224008.602158-1-ameryhung@gmail.com>
In-Reply-To: <20260318224008.602158-1-ameryhung@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 19 Mar 2026 01:31:28 +0100
X-Gm-Features: AaiRm53hI3twBsypp_wjo7TSUUEXxkGlM89xIEGVgxyvMZj8UcuTXXF_6l_jrO4
Message-ID: <CAP01T76xUCrDH4G2XikNvhPTn6ZbNTgQH59qt2Q_o0c9uudd8w@mail.gmail.com>
Subject: Re: [PATCH bpf v1 1/1] bpf: Do not allow deleting local storage in NMI
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, paulmck@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Mar 2026 at 23:40, Amery Hung <ameryhung@gmail.com> wrote:
>
> Currently, local storage may deadlock when deferring freeing selem or
> local storage through kfree_rcu(), call_rcu() or call_rcu_tasks_trace()
> in NMI or reentrant. kfree_rcu() and call_rcu() have always been unsafe
> in NMI. call_rcu_tasks_trace() only became unsafe when it switched to

It has also always been unsafe in NMI, so the commit log needs an
update. We should also note that the correct solution is
irqs_disabled() to completely close the same context reentrancy, but
it is too coarse-grained for this case, and we can revisit it once we
convert to the _nolock() variant.

> call_srcu(). Since deleting selem in NMI is an unlikely use case,
> partially mitigate it by returning error when calling from
> bpf_xxx_storage_delete() helpers in NMI. The check is only added to
> bpf_selem_unlink(), which is used by helpers and syscalls.
> bpf_selem_unlink_nofail() is fine as it is called during map and owner
> tear down that never run in NMI or reentrant.
>
> The long-term solution requires _nolock versions of call_rcu. Another
> possible solution is to defer the free through irq_work, but it would
> grow the size of selem, which is non-ideal.
>
> Fixes: a10787e6d58c ("bpf: Enable task local storage for tracing programs")
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  kernel/bpf/bpf_local_storage.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 69bb2a7a71bc..cad17ca8552f 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -393,6 +393,9 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem)
>         unsigned long flags;
>         int err;
>
> +       if (in_nmi())
> +               return -EOPNOTSUPP;
> +
>         if (unlikely(!selem_linked_to_storage_lockless(selem)))
>                 /* selem has already been unlinked from sk */
>                 return 0;
> --
> 2.52.0
>
