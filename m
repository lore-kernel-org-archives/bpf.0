Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE3A31B83B
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769825355; cv=pass; b=qTue0rtYBzOr3aOoCnQAEGOKhvvr8pOW2oClyOdssDADjA9LR1OXLHNLuwXl3bv/Woofni51237bG2Qx6omFwAoXf9qiYqhtfD2aTLMQLBTOE5UNGvjLfXwdYSmorKRQf0nvEJl8hqPC0sPXg3nzuVcqBXQrbQKG0isD8fwDyqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769825355; c=relaxed/simple;
	bh=q1+m69AC8OyppS+g1qL0airmm2fN+rGF7m5h75RejBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+BNFxKREAIksMawfrwwigPe+MVvdOInoTicJAwuGW86jXZQ1QyidN13r5mmyils9jrHsUyhaCbX9qNABf58+KzH3101FfdRSQEem61aeiGVKjeyphl1HgqVzC47NLL3sp3bqsCA2yGWYvz7WCWJ15ppfPsTbVk9lrQ36Y719m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mdY9sAoL; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mdY9sAoL"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8849dc12f6so406058466b.1
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 18:09:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769825352; cv=none;
        d=google.com; s=arc-20240605;
        b=jvy5rIkevazkcVta0OyrelEJcPIXkGNRqyTRT+Jun0h4eFH3FIS3pr6IZCyTefCGYu
         D4D0ML2GxMv9JVjid8EHb+2rog90JEoWnF0uk90jt09gDXxQo9pYSEmKwxQS4yUwSXQV
         dX6hxwqVbFH16K6G5ZG8q82tWu3TdWcqensUYsow4msyG/wcTjTdpr2X8Wc+g6KzfwC+
         TGzXcDeWrfS17/4zadnEvPxZK8cOXgQucR7Lo0UVrhRA4XXd3GwafFUvSnJu/udWf52J
         goUgvBx45Xcb0HdVyYgvvrBmfFUtWgOZEw311aIZvSbkr9BuH/Eci2vOzvq2ekRCfkTO
         P1kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fXBSGIys3SzCpVetTGHBAjMTb+eZCN0LoIysZIFKUFQ=;
        fh=bX+QiU87fF6FQmRRRPvVnyO7NMSULzg4Bv4oJyI+lZI=;
        b=hjSYm4B46mfq+gDvcHnoVZ51VCvk5MfeXP4QEmynYmjmLpvQIXNQFmfY5sgMS2V50r
         BLRfX5CAb4Nw1O9tWuZMTC7nPTIsThBU1puJMboUhU+fQ5WNC/O/eKvBd6oUCJoWVcxR
         6E6hn8YK9vWMxsaOdyZngVIoJ9fhYEHhViaIhZRhiEURlsObe+XxNBPHbZimuXUGi22+
         ENv/no+019M1zbPpawL7lbnUVQHJgDV+RloNgI/AZ4ATO1ekIQ5EcNdJ6+7t+RZdWUEQ
         ndFXsZ/1j5epYfxMi70wFL2aWlOys/pYZ4/Hd1yx1Qk3msUKTF2ixsDvs9LKboh73B06
         HuYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769825352; x=1770430152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXBSGIys3SzCpVetTGHBAjMTb+eZCN0LoIysZIFKUFQ=;
        b=mdY9sAoLvV09pJjCxND5Iu74NfN+XMMgrupYs9by8DK5G2zZFOokwzfRRZKmBD1gRY
         AjgQpgB5EjSE4J0xzK51/PodGanFU83GL26fHQqfL9/acxZXA7eQC4icggJ3OPvsx39F
         rYB9x3Oswo696/SSnggh0yy/9Iw7SYfPVlLnKssfKPM5puJqBDEgC8TBKfmP2p9p8y9J
         mT2bVhCFO3fDAmUxql8ri6GZjywb818fU2vt3kLT6LeM+Nf8WkTqwYY0efhXBrLT+AY4
         ERI/xwg6zoS67zkSfCmJiRPlXMmkdYhH8jWl+xYzOwFG7Hx6lv8E8XyifBvgTABOhkOv
         aGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769825352; x=1770430152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fXBSGIys3SzCpVetTGHBAjMTb+eZCN0LoIysZIFKUFQ=;
        b=suaWmfIAPNZYqZjSBAr4kXYSWctHvBNkXQV3ffX4dqXQMKOjgusFSQuMKh8F2E0T/W
         7Okm2Nak6+YnqXOyfDTNfyqqphK+/Aek/5DDx3quWY3/IKpk7Q0k6MyOtfe65ySm+XA+
         Gf0H1yS8awgnw200oRiNYMV1zx8qw+lTLlathfK3yn49o75G+mCwhot+1YWRp5Vjz3xV
         dXcB2djyP6pZAEy8YbzvWcewNlvdceg5HFOZruSNHjGgt6ceTaB78Onru2wnkbniLgX0
         wu/ggSbLfoEViEyRQtlDDSmEq8lpp8USPw35ir3WBcYCrj4NeaBghWLD4z10CPtHhpIt
         ZxKA==
X-Forwarded-Encrypted: i=1; AJvYcCXghZCbYp9iQ5+Jayi6OnZcGXqCzK8J/pu65oeNgMULkffHsti+ePdCxqhkoYIYACTp9HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhxJgrwWyPcnVUBj80PS/WKL7u2RlZJlmb0FNUGyh8MYXy7BIC
	0wLMitGLC5+nXcSKa06yv7hpmq7LuW5Hh1XewpcMx6dVjkX8Wb/Z64FspyudON2+hRl3THvS1w0
	1InSkG+QB7+ITE38FK6UhGnf+Rr0xGmtkEYrH9Z7/
X-Gm-Gg: AZuq6aKKPoKUu3+INm6zsUlfrw65O2ucMwlH/fZsuysHYLW7DF/6qj51aGcUrLW3UQT
	z+kcb4+nlP9p/sjYG3/nRN2DwSjeh6tRnDzDPeP56SJ7KcLD4QaUhwEptNx9KTrHspjTinCptaZ
	UtuMwu9NVa4BxBdIeJfOo+ro/rEHJkFM2QK561aB5zXaqT8iZSYQWSG/i0JHjujUjyBpTFW2chp
	TAvWlcT1TGlipUznKT3fMg6Kpc0Al5ORm6R19ttOqnme+P53EvaNDfdOhz0wwcBX5HTZU2RFEjP
	pZo=
X-Received: by 2002:a17:906:f5a8:b0:b74:984c:a3de with SMTP id
 a640c23a62f3a-b8dff5d84a1mr304116566b.28.1769825351931; Fri, 30 Jan 2026
 18:09:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV> <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV> <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
 <20260130070424.GV3183987@ZenIV> <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
 <20260130235743.GW3183987@ZenIV> <CAG2KctotL+tpHQMWWAFOQEy=3NX-7fa9YroqsjnxKmTuunJ2AQ@mail.gmail.com>
 <20260131011831.GZ3183987@ZenIV>
In-Reply-To: <20260131011831.GZ3183987@ZenIV>
From: Samuel Wu <wusamuel@google.com>
Date: Fri, 30 Jan 2026 18:09:00 -0800
X-Gm-Features: AZwV_QgpcNm32QTyYTJNZ2e8MpZD_azq4tiS_evKebHi_xWHPJAAyFUDpR04HdE
Message-ID: <CAG2KctoKDsfbyopQYq3-nJBg3fG+7Nrer17S6HqQ+nCWEcHeWQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 5:16=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Fri, Jan 30, 2026 at 05:05:34PM -0800, Samuel Wu wrote:
>
> > > How lovely...  Could you slap
> > >         WARN_ON(ret =3D=3D -EAGAIN);
> > > right before that
> > >         if (ret < 0)
> > >                 return ret;
> >
> > Surprisingly ret =3D=3D 0 every time, so no difference in dmesg logs wi=
th
> > this addition.
>
> What the hell?  Other than that mutex_lock(), the only change in there
> is the order of store to file->private_data and call of ffs_data_opened()=
;
> that struct file pointer is not visible to anyone at that point...

Agree, 09e88dc22ea2 (serialize ffs_ep0_open() on ffs->mutex) in itself
is quite straightforward. Not familiar with this code path so just
speculating, but is there any interaction with previous patches (e.g.
refcounting)?

> Wait, it also brings ffs_data_reset() on that transition under ffs->mutex=
...
> For a quick check: does
> git fetch git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for-=
wsamuel2
> git switch --detach FETCH_HEAD
> demonstrate the same breakage?

Had to adjust forward declaration of ffs_data_reset() to build, but
unfortunately same breakage.
