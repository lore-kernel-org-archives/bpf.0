Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41AE533D6
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848041; cv=pass; b=bzFccyqHSLcKXarukshiu4fg7zcDYwAgSHEGi3BUIDmm63nRtD41e9B+itlbPCLn+o0d0bXXAwDK+Yd4bEssw1eP/K2A3C+4UQDm52RjGe2DlWyVmbUUMUMlsO85W2XE4+JE37jfXjbMY9+0WYzjJUo2OBE6YMFYPBWMDzrBR1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848041; c=relaxed/simple;
	bh=scHt+iyBMWOylqgViJ5vWUnmhF3RxYRWmtqm5Y6wxgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Radgyp4ugBpafXrYTJx9jq5gmPZHe7bpIdKBLCNMZU92YrZGWgukSEI/Am89US73tQk5quDDbdlU0xpyuRV5GWeiclkR8eZ1BgqN2BQ3qKjmPf0ll0fYV7sH1KV16Xus2j6zPZY4+XhUZjnbCFXTzbHaGKDU7SndN7rqT577c+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ohb0qiN/; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ohb0qiN/"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2caea3f742bso771115ad.0
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 09:27:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787848039; cv=none;
        d=google.com; s=arc-20260327;
        b=UnmhX4+oK0bEA9XW+XjEKQQ7G8lVESe/Q2MrgjREU8dMzuU0VGGXTUZfQ/UDDeOc4t
         ccfZBAkWC4JfObZJtL/DqhWgXXdhzzvo57rkq4iDnKGkQupId6SAbQ+q4S+70pSVuRue
         cfy4/qa8G5c77F18am1FP4++P3j20A9tMbehxKWhbazQ3mLAVt/dXaObn9r371HPpYum
         dWDY5mJBSR3h6YjxzDqY5Fu7zZjkHnTAem/0i2WDfZavuILQLbS9/MK5OadD7rcXgPYH
         B1OLXFY0E6nQgJk3MN3EujzZk4tIi8WExvl7CCmjD641NIsrHEJHaeev4t8M8G0RcjVl
         9QVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UbwPgsLbQuTsRud2Crpt7fzATm/uz+C7nDTDVjlvWGE=;
        fh=7JGPwTaHYJOPhwCj57Vwl9Dk2HxAesV3CtGtA45ldvM=;
        b=J4wycWLl/+zo6zEjHdCKtMUiU6EGrJH6WeBIzjmD5qXObJcc8inQGvdaw7UmdtZOMc
         Ml7++vqJLDQE4xeRD3dJIFvy+bSjgv/q6hml/NVsQ87D/7BJSqCaYd3CEbUXOqVd+O16
         VetiS4W3LjGXNyOLk2zWLWTVUbX0++FbmIl+Xz9LevUG8SFYwHSJd0oH7I4azuwYheOO
         +VEHkxFLUPR9U0p5ESqm24Xt3F5+BqG9jN4yAEC06s0xuke7iQ4FvidSK3AA2FNpl98C
         VRrj2gqNPV+sQ42I7x29+NQnkmy5aDWP3BvRxLjJ/wcSld9V3bP5GqADoIaZZwWKEvB4
         oQQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787848039; x=1788452839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UbwPgsLbQuTsRud2Crpt7fzATm/uz+C7nDTDVjlvWGE=;
        b=Ohb0qiN/o9MPjWTxdhYEPdUKbMjegC1R6w8c1yEUzH+3AEVpw7v9mnjOE5I4ssvBwR
         gbGYzn/NNzvWTNUyhjmJJZ9wGY33PrB3H23hX09TUj8BBeWQOYEBbQRlqB90VdVzjh5z
         6Z2E+6ehJv377Yp+lKZ5xMRm2x+KlOnU5YqoGPm4kao1b6KLY+a/pkuAWjPVjWJBlf4r
         LY95nHIGm7oNTYVQJ1QWxLxUtzOIRrWWmfSFgw+n7+V4TD5qUrGs+CP75reU+sGrSRZC
         Y5/1UQLe7i8C+s3H+mjPxGcGVRT4/fhifK1VKfnKMdlyCDlyzCwqU1k1AH/E8wGhtOk9
         loJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787848039; x=1788452839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UbwPgsLbQuTsRud2Crpt7fzATm/uz+C7nDTDVjlvWGE=;
        b=a5dJdEkqexZy1T9ywz7IMNsJcAKzwUvSIRnf99wWxE08ix28KozOWrNcuIdBIIR8ri
         9Dcl3ZZ8EjvCNCmweJd9WXEhdTVZVQxqS9g0wushne3c0tP+6HvldO4Y/Pi83mQ2mCSo
         4Ot+b86nC18lAiCZAnMZnB16xHSp8Q8Lx8QM/oVK2/ACRVwX6wEfqGbcdxQP5p4B+hNv
         7niHrFH8UnvapLEqrz0VvfCysKdxtambZxp2SOtkwxuApaHg7ROeAlPmG4ddSFmSvvFT
         UM8mzUmixdM9BpZXsd7WWB8v/kBZ1VNU798PTk9FYT5TfOmLbi1ha6ChynE0nkiGPYbh
         fDUg==
X-Forwarded-Encrypted: i=1; AHgh+RqUKWjaLMxrXg6DWTywE19VfsQS1beSWut2mEaCtlNUEujf9R7DFgg5VdapxYJ7uqm5lbA=@vger.kernel.org
X-Gm-Message-State: AFuF++mL4C4lCZ7vvjZNpyn2WRuQPjJTgeunSTzUiY+u/f7Y8vAOe230
	gth/8Hq1M2hSrsPJhh4RrjcO15EtpC3oSTseEGMlgY7pbVxILDKti/M0UDcMrpmBlpYAKbDqXha
	yGLunbLJy1VfEZG4Vs74qhqJsxP3mlx/ZUbzwt4SO
X-Gm-Gg: AR+sD13hfwhdRThZ+B9fe4QW/LBmDnvj1sE+ZHdT5yM6jtpuFu1k4YSxOiru1ApDQ1Z
	eDCiHVTafxsb74hwBDArJx3AR083xVHbTmkyx3o7R6xI0vsF6A9T8kiYg7OIXnqDpFMun9tNaO4
	/cCe7gWvuhYbDuRBt4YAldbL1/jpItBm2Itnxhsy5/Qr3JR69PdqbXvB96UI9JqLHuWL9bV9Fq/
	GZ2t33/8jwE2pdKKIg07n2EFrF8WEgLjAHa0Wg1f6gyrdnv3CdzCsniP+XE3Lq0EOM3M4xqBVlf
	p0FlJ2cnmlUMGHyFvUETdrwHYFt56tjbMEZXHy7Le24O1f+clKPd2VgTqVxPNVbULiyUlpMfJ+7
	d49GQXmcjzxjylCpyMD++bMj5wb3MxzggW5XHa9lgYaCpczvlBXkZ2IC+b9xA8vegWpm1/swGuJ
	sE9LrDy/0+rkBvbg==
X-Received: by 2002:a17:90b:5905:b0:381:a766:efcb with SMTP id
 98e67ed59e1d1-396d0d7b94bmr843184a91.4.1787848038204; Thu, 27 Aug 2026
 09:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827132133.439890-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20260827132133.439890-1-maciej.fijalkowski@intel.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 27 Aug 2026 09:27:06 -0700
X-Gm-Features: AcwNN1X4yW5ISKKrAOkksq3luyXi7C-3OgDl_XVbJ7UICT5kfCRGrl2-Pqz4EZs
Message-ID: <CAAVpQUC3w4b5KG+YGrK7bDNoaL-RPpmEu3FVJiyzWPewoJt2=g@mail.gmail.com>
Subject: Re: [PATCH net] ipvlan: unregister upper devices outside pnodes_lock
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, magnus.karlsson@intel.com, 
	sdf@fomichev.me, bpf@vger.kernel.org, 
	syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 6:21=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> syzbot reported the following circular locking dependency:
>
>   xs->mutex -> netdev lock -> pnodes_lock -> net->xdp.lock -> xs->mutex
>
> The pnodes_lock -> net->xdp.lock edge is recorded when
> ipvlan_device_event(NETDEV_UNREGISTER) calls unregister_netdevice_many()
> while holding pnodes_lock.  A nested NETDEV_UNREGISTER notification for
> an IPvlan device enters xsk_notifier(), which acquires net->xdp.lock.
>
> Keep pnodes_lock only while marking the upper devices as dying, removing
> them from port->ipvlans, and queueing them for unregistration.  Once the
> devices have been detached from the protected list, release pnodes_lock
> before unregister_netdevice_many() invokes notifier callbacks.
>
> The port remains alive across unregistration because
> ipvlan_device_event() holds the reference acquired by ipvlan_port_get().
> The dying flag prevents a concurrent ->dellink() callback from deleting a
> queued device again.
>
> Fixes: 35add1093e2f ("ipvlan: Protect ipvl_port.ipvlans with mutex.")
> Reported-by: syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Daa48b5fe7bfda62d1682
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ipvlan/ipvlan_main.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan=
_main.c
> index ee46a55f73d1..2730581e0a56 100644
> --- a/drivers/net/ipvlan/ipvlan_main.c
> +++ b/drivers/net/ipvlan/ipvlan_main.c
> @@ -846,7 +846,6 @@ static int ipvlan_device_event(struct notifier_block =
*unused,
>                                 __ipvlan_link_delete(net, ipvlan->dev, &l=
st_kill);
>                 }
>
> -               unregister_netdevice_many(&lst_kill);
>                 break;
>         }
>         case NETDEV_FEAT_CHANGE:
> @@ -895,6 +894,10 @@ static int ipvlan_device_event(struct notifier_block=
 *unused,
>
>         mutex_unlock(&port->pnodes_lock);
>
> +       /* Avoid invoking nested netdevice notifiers under pnodes_lock. *=
/
> +       if (!list_empty(&lst_kill))

nit: unregister_netdevice_many() takes care of this.


> +               unregister_netdevice_many(&lst_kill);
> +
>         ipvlan_port_put(port);
>
>         return ret;
> --
> 2.43.0
>
