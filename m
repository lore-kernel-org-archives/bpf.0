Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7503B13635E
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 01:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778549640; cv=pass; b=rKy1Uqm2NMX4x11YBpzJ3oz9MKFsapacwI4oYuhq9RNfM/x21GhnMSOSz7ws9fHlSKDg7xfSulQJJ0Z+RSzaZj97Bh+E6MhAWFKs+FPg38borm89OXpFAtNiWoD/T8zmdJv3dAiL8pNCqs7se8KLXsoU1iE9WuldsBq8Mig9IsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778549640; c=relaxed/simple;
	bh=YFYc9tojgSqvXxypiG3IDjTeZya/xon5/9mPtZhqelo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=naNn92MXjJ2QzmTM5NN7vCoeaDcUdJ8PkEcjrZ5YpfYRjVQ6Y5Vm2PcWZ8DUk5l67oVGrKGrK3ma0007DSJwWFaVu5YMhxYkwiSfK+aPbczt/F/ua16/gRJMDwFX6q4N+VL5KzQjzbp2/U3OjIGgfiUTOU5S/UMjLpbwI5RqXek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aceLbaBJ; arc=pass smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aceLbaBJ"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-488ba840146so43762715e9.1
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 18:33:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778549638; cv=none;
        d=google.com; s=arc-20240605;
        b=fU5YklhP6XtAyNjOfSZ78FGRuCPp44UkC9KkuKATX+6/CkNuPIYyC+KcSlD9AQHYfu
         sntoY2X+5w1GWiX6HNAmX3ihjpGqdT5N/eEPKHFJqV2lBuhwCIcLUkqt2+wJK5jkh5XT
         J/ltBapaO+L/oonXgVTwlIXJ3ZS6CRLedWWEtzVRjs39HqblML02PXDLwCqMGAWzto14
         ibrpfA7uHuEIYtsp/fqohthAd3hP/LIDjYIXYfsISyBr3fgQntJ8/1b4WNy1cCuTk7hU
         zbY3JFFXjA9Yeuw/3EF5HfjRW83qvSLjtOBDXHunJI9Qx8tp821FiUXaxeD1IFRw7np8
         B3jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=URTvd0X2bB9PlvQypmd20qxYyxEvwE5TSBxW9Nigs6U=;
        fh=VGJ5ERnCTT7JCjaiigC5QOBZ2s1GOKEk7HnHiQ2gAiY=;
        b=caCSDmGNt6phC/mLdaY+mbfTQpw507hQJOZ4LbRyPXpA91WjlNlQWUUeT0Dd3PhCxv
         VYFL6zEbTUpc4dYit4kqYh8QrYn/okdEJ406wAbQIktCvsxfLuXvqE+J21tQ6Mx2aTwC
         BNLyMWns1qNBtCzj89T2bs1d0HRsOreaCDvL+F4UlhFlJy1/qvg9sW7M1ir2hFROsBzY
         5Z3obPUNjCYsI0nQU4Gs9RsrL1mFap1Hqm1PfGNwr6Da5PjIZuW/YQd5TH1WaRJRi2tZ
         F2pt2Hito2Cbhy/77gy/5wIDxNAPQ8KsTFO2uPnHR/Y4d5u1Lh08Q9JdaqRYDdYe/5ul
         84UA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778549638; x=1779154438; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=URTvd0X2bB9PlvQypmd20qxYyxEvwE5TSBxW9Nigs6U=;
        b=aceLbaBJf2FoAcGaUL9Snqbeh6Pe3CJ0LbvOXzkFreg50w7Juod4rzNQNO164NP8Ff
         5mprwTVpK3cWyFCpSfTlleQAUj9EtvrLZxlgflDW5Dq8bHEoCLATj0QguL+4z6EY6C+R
         qJc4ONK7LP/YM+8Opeb5y68ISrhR2JKZoaXxdUqHZ3tvR0izKhavxC1qXc70Wc4lQkpH
         tRxa1RdjxzLwrDKGIVWrvnkMW8SKZUk5V0zooQLejv03xfpr+k5lrt+WjOb6tkpCjncD
         cGkxZHe+n5CM5NDB4srMfmODGLRPZkUvU638rJgRJyEcjjUOPD5gGSZvuU8NWLh5b+mX
         e21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778549638; x=1779154438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URTvd0X2bB9PlvQypmd20qxYyxEvwE5TSBxW9Nigs6U=;
        b=i4P2tEWXIZmep753rJkN1wsuHYMXJHyvMS2ZYY78cC1HOoHGD2qG88WPBU2qSxZQus
         Cr6kpMHyjrSBi2zRFcFntYOC132XJ0C8JdruEVZ5mVKA+VBIcj9FfQPPX9bCuC23pTF7
         Gi/UMcD1dc3QrHZJETHtY0/inF1b6z22K6xP9YSnyl/K8SOhdtfXCoQzcAwk9GjSpilY
         I4zpIQZHyyGW9nWx1gRuq+KspciXWxsh1ReYRfTrd/w+g1O+eZiBVvKoaGs+jWGiq2Vr
         DdVXihHKb5zeTTfMfVRL5oSyST+IYTM7FgNLjpL4n3V4jhx5awc3GhEHK8A+2ZJESscX
         4hdA==
X-Forwarded-Encrypted: i=1; AFNElJ8GWIQ2CZ7TE3AGcj7oa7lxAsq0/ZiXUnnRQYJa6yirgtYAtFm+qbha0r07CBAMmA0Q1N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YysI+iF8oE7FyZTzEZPX/nEc43birWNuhHRU8ARmMFfiie0hVqQ
	/lZpL89hvwtAM10K+ueCq28CXEB/5BY5qEcFVIb15psrGUpq6KgJ98stkQ4KVO4Tnlsp8bqy0tY
	RGvZq6/o9cxIBZzH7FwwT/lGLPYZGD4s=
X-Gm-Gg: Acq92OHupBijGgfEzfghiLgAzxOJr+wgpj/nE9Xj9iPQzDn49+lYX9mC/AO1duCKSf6
	wnPdKkBOn+RhFFqARXIqV7bK2qVSYtAKt74EVA00lUrP4yhdAPdQCDRld+EduAc86gPk4EoqcFS
	vHHOi/uyeXCewQzm1hHVdkXxnd5CclWyviDqyubuQ/GeKbBL4nbbPnV9KN6gR8Cv+fGpABXlsxt
	CT2LlzfQzTaZyKjwiMs33m0W8q8QqTqfUPXjW1h1v9t52dwjKV1/wGQc1mZFAueMmAFu7Cf5mlH
	nYpK3dW4ax7/UTZo+mCkeGh5ZfZHGf7XmUjd09G2i9zIOBWeVWVuZf6yt3aSkx9hGyjHUg4OYZB
	ZOrfYnhxn6/py3K2JyQYYCOg2BAIVuQnDghFL6Z9yBDMaw/FHDISlL0N1
X-Received: by 2002:a05:600c:45d1:b0:487:1108:48b8 with SMTP id
 5b1f17b1804b1-48e8fe4b2c4mr10900915e9.2.1778549637725; Mon, 11 May 2026
 18:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510030136.27876-1-chensong_2000@126.com>
In-Reply-To: <20260510030136.27876-1-chensong_2000@126.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 12 May 2026 03:33:20 +0200
X-Gm-Features: AVHnY4I_a1b1YErEUwSZ8KYkbdkvu8Di9aFEPDvmpvrSEdS63NY0fam1fm_OY58
Message-ID: <CAP01T77aPyqjV+9CVVL-YSEajvQYaMg9SNX3fygr0kTeKrBquw@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] tools/lib/bpf/libbpf: Prioritize module kfuncs
 over vmlinux kfuncs
To: Song Chen <chensong_2000@126.com>, andrii@kernel.org, eddyz87@gmail.com, 
	alexei.starovoitov@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 10 May 2026 at 05:05, Song Chen <chensong_2000@126.com> wrote:
>
> Change the kfunc resolution order in find_ksym_btf_id() to search
> module BTFs before vmlinux BTF. This allows kernel modules to override
> vmlinux kfuncs with the same name, enabling a form of live-patching
> for kfuncs.
>
> Previously, vmlinux kfuncs were always preferred, making it impossible
> for modules to provide enhanced or fixed versions of existing kfuncs.
> With this change, modules can now override kernel kfuncs, while
> programs that don't use module BTFs remain unaffected.
>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Song Chen <chensong_2000@126.com>
>
> ---
> changelog:
> v1 -->  v2:
> 1, introduce namespace to specify which module the kfunc belongs to, like:
> modulea__foo
> moduleb__foo
> foo
> As a result, kfunc foo can co-exist in modulea, moduleb and vmlinux, ebpf
> code owner can specify which one he wants to call.
> ---
>  tools/lib/bpf/libbpf.c | 60 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 45 insertions(+), 15 deletions(-)
>

Instead of modulea___ prefix, how about using declaration tags instead?
We can use `namespace:vmlinux` and `namespace:module` to choose
precedence for module or vmlinux.
Then further scope using `namespace:moduleA` or `namespace:moduleB`.

By default, I think preferring vmlinux symbols over modules makes
sense. If one wants to prefer an overload with the same name coming
from a module, they can place the right tag. But we need more
consensus from other folks before you respin again. If we didn't have
a way of indicating the preference, I would agree picking the one in
module would allow more interesting cases by default, but since we do
have a mechanism, it makes sense to pick a more sensible conservative
default, in my opinion.

Anyway, let's see what others might say.

pw-bot: cr

> [...]
