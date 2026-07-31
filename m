Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508AF23ABB9
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 00:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785456075; cv=pass; b=h34MgfL3j5J5YhcD6C4cY98zAPTBbgWyZnDDEpj2JomzDZMARn+dwxlCvkjGdS3kvykC09uZjrpFR4aI73Xkx1qje3K6EoaaCxVgL7hTuQO8ltgWPZTF3/GnoWNMIdi2m4jTgPPlOHfXmkNxGCDFpOSND2ZI8eczM1QLPhPV5R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785456075; c=relaxed/simple;
	bh=jkjv3zkZuKcst+AaRQDTEpkwTvvO7l2pCMgYw+titho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZZUlS2mwMbnHTFSM8jb+UTNT5ewiAHe4dTlRqNuUg8nLMFdHnnl8jS7rlO02uHhXzaH1Z57smf5dFapxMzf6h1Ff7NizBlUEia+T9HtwqF8yDyU3vykLSJpeN/Fwge9sJt6s2WgMxXjrr0XqHJeOFQfdi6t2eOBQevHDub/eus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lk/DigPl; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk/DigPl"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c05dcdf49so3730991cf.0
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 17:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785456072; cv=none;
        d=google.com; s=arc-20260327;
        b=N6FUjUIVYG6w0/MPxblv4Wq4y6ffCO7v/FnQWbMByXvxcJeRPkSPXXA/QLEkmnVL2s
         a5Id8Jq4IM050s+twe+KRfeaEArzRD6px5CIt6YrRC41Vi5HtD5hiTXk7BS6bw5tDE3T
         CpedLqb4rSGQKM6n41Y3QR9doBf9L1s8rTLTRcyDjqMjmnGGR7LFKj1o/v+CjjW0MP6K
         Aq4UWeGg3MzIIOw4YUpuxU5BaGilJE2iIhTr3xdIgdhVymjnXbMMNc3rl3Mr4MoITH7U
         wThRymEtfGjWQA0AwhFnvPhRJsLMtKhqfhnByRTrM7igaKDExuhPRXfZEtxp19okhO5u
         tuSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jkjv3zkZuKcst+AaRQDTEpkwTvvO7l2pCMgYw+titho=;
        fh=a0yulcGLV2D0F7pzZiujLqBOUFEUN9x2KtWRicI8v5A=;
        b=rI9HerKH8t53MFSdIA6O71wm7ko9QUmGwXPaWid21JJ0pkMmn6fEiDyFUaXCXfbMai
         q/WNoYzXm9RemzQPAQq1/vVqG2zrqM3IS1BJvuARYHpKKZbOx/PBDU4tGhcP9z1faGmT
         a9RvJvpp05QEJX6V8zrx0tEaSPTTen0p9hKDWAXT9klfPwgwlQYp6tKJGMIvbfeY5rFB
         EJT2ESxZ2jyZynIp/B73FcmKPB7+yCsH7y89XzucINM9UXG4X1PPE8tQ7IiMh5kOyoXp
         qWGEKOv/lVsA2BiErchyrA1SBolKCEZnb8cRIz2X1AE9T+wc0Bs5PXo4VYtUWbaluLjz
         a7ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785456072; x=1786060872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jkjv3zkZuKcst+AaRQDTEpkwTvvO7l2pCMgYw+titho=;
        b=lk/DigPlxuCIVbt879jIb6r7+Nmnr5dRWu2ogJeOmjjYjmD3QHGH4CSuEKHKoWHdhn
         AkdVhyIiBI/9atob2UT3f3XBr+Gwe/XQr630TJhEO8Td2mvak+gSBnKOsvd7JDzA2BpU
         802CBeK1z42D9bofWzkflLi+NCEfsgwcPJc1UKLMxl36m5WuF7T4L4mzzcHfeuyeJuK9
         bcFgGVdoJvnrF2886wiECWyWlwHg9e0BOXhMICgDnf8EmkLNVlCKwPfyw6I5QEhArx2J
         SDVPl59nY1Z+PfLyQ5k11S2DmN7I7ltlCukpdmARMsRI6b57LbPsiay8XnUQ7GT7+xj7
         MSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785456072; x=1786060872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jkjv3zkZuKcst+AaRQDTEpkwTvvO7l2pCMgYw+titho=;
        b=D4IuLk8/xp5HeLovgNReu+oLd6hBH6jSpdcZfOiFH1XibiVz8bnTb/bxV6c6ngmhDj
         kg3aHXXpCAiasFIWer6MslCn27ZN4U1j4eaQqNSR/GHrPMcOs9O3DSrz0aOgDZGjBDom
         GjudTOoCotmH3+DISbqbWeCQBbH9DLP7XGwMwip/tvF1nLLzCCeMWetIkIXCzePfq+V7
         gD/R2mEKaFVRre9WTaj0VRtPByKDSa08sD1TfSf4Eh4/GAocxhrHfnNQebPNojmf/4rD
         yZQ9d2VZgdp1xWRIx0iQ4XSkaSH8IRGlI7fS4rBUp2KBSrLqt0y8M5egB2+eJ4gJnbi0
         myJA==
X-Forwarded-Encrypted: i=1; AHgh+Ro5wdEIA0UBOWlkT+qxERmgx9exvkuhGNMUttfpM7Jwf8m3yQUZyCbKIySSpwKBsmJ4JAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyUhxRbOzicbyIB7JB6z3iyt0opXHHm1mXegYaWlo2rmOBxWCg
	NEgaLlEEKgS87MsNrKVzDVFZSythhprcxv3uU8gx8IvgqGFUzcA/Qw+BrITBa2qajHDt9W5iW2R
	CAsPeayheEozH/dQ3zUN5Up2VcMuT8Fw=
X-Gm-Gg: AR+sD10uyduElfcPrKiibdkVDCxrA5vA++IZXKkdk9gcQVu4o+GQVAvpWlzdEBy8U6F
	0L61k2TEIM0/e2xexNyCrZdsEohriUMZX0W9YtMBtr6RUbAXd5FwFlWhoF3wBWh73kiAJVdr+mp
	kLqxuvUXG8Vb/LIh8TdhOidQ01v+CxuG8/L27l7DFiaxab5L/WE6V6ObmwUGW212Et2d9rzjFvM
	vg4/EfVlf+zonsRG7wZpEl5BDuO59tekQSJzjz54G8Ybrn6eUj63pjoI1VZgvrAaL3mrSPY7PQg
	e1lYMxKYZlFhae/KxdRcf1bu3VID/arfn+cKm456nz91Iqv2VywgCDCunVptrE8lfQCaCqHP4jo
	=
X-Received: by 2002:ac8:7d0c:0:b0:519:e3e8:85bc with SMTP id
 d75a77b69052e-52b4b005354mr130221cf.37.1785456071885; Thu, 30 Jul 2026
 17:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
In-Reply-To: <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Thu, 30 Jul 2026 20:01:00 -0400
X-Gm-Features: AUfX_mzzLAETGk0-GNkiDsgUNvOmEZOv-UFFgDdgdht4DdfS7DnllTiGk_VUitE
Message-ID: <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Paul Moore <paul@paul-moore.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 7:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Based on our discussion in the v5 patchset, I was expecting to see
> this under security/; did something happen, or was there some
> confusion?
>

Nothing happened, perhaps some confusion. I was basing the placement
off of Kumar's comment in v5:

> I don't think we should do that in v6 though. What you're describing affe=
cts all
other xattr kfuncs. That's a broader discussion we should have separately w=
hen
folks are back from vacation, and more importantly involve FS folks where t=
he
code currently lives. As you say yourself, the lines are blurry, xattrs are=
 as
much a filesystem concept.

My take on this was, leave it in fs/ for now and then litigate the
placement of all of the fs-related kfuncs after bpf_init_inode_xattr
lands.

Happy to place this in security/ in v7, if that's preferred. Apologies
if I misread the thread.

-David
> --
> paul-moore.com
