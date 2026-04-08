Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357512E4274
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 00:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775609238; cv=pass; b=p8F0WLWVFoPkQ6QGEqrF7JZT8DtD+uuz+Z3+06GUXbgDDQMRJhxEXX9UXRnvdWvH8m9/Qf1YLeBoHNuylJac8yQCKctmNX5oHgIFf4c2uoUit4pa/xaWGrdB0rT73PIzCSbjemncgiWCzPHKqT9JEKarekMcQPCGGOkwtJbiXTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775609238; c=relaxed/simple;
	bh=DEsI0BgmtgLBAsle4MGY7bLXYBY4CxWUL4evHL89W7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMjsrrRhLJny+RFoknlN7RrzMMwzCpPqOO2YlWr6pYaiSdZL9nwUPoUtZPrg62Sqj/tfKI5ZZwdwGqu6Z3cgYBszs3zcbVg4PHjGiOqwtbCgfxczahNv/MyjKeky7zPca68braAKHL1VMjLnwUG6PZ6gYaJiWuzIf6t9nbziKB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KKvqJdv1; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KKvqJdv1"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66b0dc690bcso2985a12.1
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 17:47:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775609235; cv=none;
        d=google.com; s=arc-20240605;
        b=SVeU8sA8B+d2+JcoAXRERFCCz+51K/YISkC+NUEvcONSBJ5DPfxBNQrzM47/DwzrEe
         2e+/QvBfIOdE9tDkZxXoCS50e5ZNZ8G0Vx4cWvUVmTbYjRuaPfHp9QkLFHOTb87JcluZ
         ZyWFhjUfsqADZIzDb0LjeDzJS9zhclj0acPler072tsNnQCy+rCuNho9av7pmH60e27n
         uAWw9HWA7QT+GaV5X7jXhBnauJYXDN5+IVRM5ss2xr+9CHYgkRi0JCqv4Y/Ofh5JGjwf
         eVmgtIEcRbZa14HMJRTTV4ZpBgnVocanedOhTh3wzWCcIg7qhE36V8bEh7kbc1R3hfXw
         pSug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VhUSt7ISpVg4Y3MHFKzYjd0CV4ZCvpoOMj+LKGHtSi4=;
        fh=USQnBnZeUuTcvi6QaU2WfHTNRGHaq89BiECmPaTz1f0=;
        b=j2WotbyC4KR968p6O03aiXaKl5UNw2F1D4ieOXJ7jVhqK9U9SNVXXlOwK7r6uNNrTe
         Wwy4iipyQXj+fItJ4B3RzHul9DFJABGpaMGzxXd0CJe1z4O3E3JM20Mu6s01aYsZg96X
         sOzekNXFQztss9rbbva9uvxX0dG06CigOdWdZ5VxtzbSUyaLxRuVwnJ50KKV7AkfpOzT
         wUQPqNiAE/DeBdBo9V6LEWx8bZodu3Sn+AyOI+eH3yrkyYts4YxHlesOm9WAdn8lWckI
         v21TFI1OC8eHnPDd8EFc3VUH3YDn+rhIChels+AYINjarS0ZfFR7vGm8PcFDmDr43JaH
         K/TQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775609235; x=1776214035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhUSt7ISpVg4Y3MHFKzYjd0CV4ZCvpoOMj+LKGHtSi4=;
        b=KKvqJdv1deFk/NCBYGoYx7KsXn37UKrHhWvdfgpGnZNPnPwsPABEoTOuQY10pLF32C
         cmAbsc4sLMEmxWTsLiuvkfwLv4H8ivPdHgM7rOjGyYSSocIogd274WfUUY8MoV7VE/F6
         nLA0DQCUxSrmzkjm3cticRqKQZ1KPnaULPsp2NbMzjnI3cdNb2ts5JPINkdMeqkzTZZ6
         Uus0SyNXXPeT24XTqT2M1mB3K1xyvx0MRVSIA0HxIbZFxn983ieNym8TZKZdc57F5sWU
         vaV6b5wKO2AaeLKNQu1LxURCR0aY+7o4KhcJDzetJru1eL5fbFgyj+W8aGR9EnVctYAT
         GgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775609235; x=1776214035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VhUSt7ISpVg4Y3MHFKzYjd0CV4ZCvpoOMj+LKGHtSi4=;
        b=BFe/jYg8guPJeeWen0xLQetGxCtR2eL1Zi7QyOBfcY0bWBlBDmNsyqHbYd1ufTPm7u
         EtWehxw9xVNnnEz1UFU+W01PPWPZ0KvKEKaAc2aVCF8Lsuq1VC+gnTaW0r1RKXMnw3GF
         2u7WghlSQeUyEL5pAujICI4SYDDmbC8mf5HWTm7+DEFRNkgz0aZ/PrGk7JTi7/Z0w+2Y
         CEWp1xu17hzAwDdT57xOGN8BWKotvdUHs3kBpC4RjHPVg1VdCH0X2fYREV/7xVHfIanA
         jXIGaKMR9aKwNtWL4rzca4e9NdSAs8LZ68sLee4LnJ0QjPV3FfL2IwXRw16yeYyLET86
         0Ssg==
X-Forwarded-Encrypted: i=1; AJvYcCUi3FYM1Iig/7VCdY6erB9uLu96NGFrfsX6OPi15mLPw5sygbpkDVptW57+6B0pHnfDvZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBuC3IkY1NBut+16bz8y2kOkInGXNdKoK2fmst+OapSFaD9hjI
	l2i/riQ7B4r9ZJazbG7eaU/m5OMNXngPQSaZaFNkDlQSpVoHb3FfyRQSXSzlieKt0Ae67iqwrm6
	qXbItr7V2F6KCI4/sTQ7EP8joFjCEIoEB/jUkgQ9+
X-Gm-Gg: AeBDietx8Gm3jtSb0cGYlsiXipcc4TvqZfr3JjWAoGalF4KsYNCQWe/v+8IzAnhSqkZ
	VEA4IzabkkKcGO7NI8ogl/S3lvrZsQMyp82034UpW7C73TrMm810Nm5ZWYv9GbR3iWU1OS2cnq5
	1XCbW+GdII5oZywcH7/gLyTK5ziH0ZYtE43ivHQk/3MAg07f9IFDqUTgGHb6rFxpggftEvQkJfb
	lcru5gNv4i1L//4uMzMLXYT1bagPVHPYXGrwEShiAT8VusfUnggbht0v8BMh0JmJUJkxfAOw+fi
	CQB8z+Y=
X-Received: by 2002:a05:6402:400e:b0:66e:e3f9:ebb6 with SMTP id
 4fb4d7f45d1cf-66f9eb0e641mr16529a12.4.1775609235225; Tue, 07 Apr 2026
 17:47:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404002149.wtayv6a64vzuppgp@desk> <CALMp9eSqgL5q-MY1xpjqR5oRn5_cb=mfEhNFWusNneS=Mx8UMg@mail.gmail.com>
 <20260404034954.t7iapenzvhdpagxp@desk> <CALMp9eR70eE2U63gzNzTiic0PqJVGv3CBBuVUOVbi3nqbWKZkQ@mail.gmail.com>
 <20260407163943.y6tkh26z2rfktn3y@desk> <CALMp9eTA3cXxuOT4dq=6y1hx52gPH1ywwTEmPQ5-fA-vz6r3VQ@mail.gmail.com>
 <20260407171151.2gf2idjbmph35ypb@desk> <CALMp9eRNVGFpzk_-ajQTuXadMtoY9H-ndUaz78wTT1zDYbTrPQ@mail.gmail.com>
 <20260407191128.b2hr2ttkdpyunhrr@desk> <CALMp9eTK0o7Z7-oTB8ohvmoh-vy-Y2qjdUvbqD6HaEhOEPZmhw@mail.gmail.com>
 <20260407222738.lrartp6evfp7yhti@desk> <CALMp9eQjSqwnvJz4JVzYpMkkTiucSJtW48zC4Hj9GBiUhOH-Eg@mail.gmail.com>
 <a605fb45-f8e3-45ad-8924-1da43b9a9e05@intel.com>
In-Reply-To: <a605fb45-f8e3-45ad-8924-1da43b9a9e05@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 7 Apr 2026 17:47:03 -0700
X-Gm-Features: AQROBzDwO89X4_V9WtLHsu6z2_UbVoDRV4IxmA1X-n2IZi_rt3P0Mq9B7UxbbGE
Message-ID: <CALMp9eRfNsghM_RnDXOs=SJYObfPa5A1aOVDZno_zJ=XotfmRw@mail.gmail.com>
Subject: Re: [PATCH v9 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
To: Dave Hansen <dave.hansen@intel.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org, 
	Jon Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Laight <david.laight.linux@gmail.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Asit Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 4:41=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 4/7/26 16:27, Jim Mattson wrote:
> > What is your proposed BHI_DIS_S override mechanism, then?
>
> Let me make sure I get this right. The desire is to:
>
> 1. Have hypervisors lie to guests about the CPU they are running on (for
>    the benefit of large/diverse migration pools)
> 2. Have guests be allowed to boot with BHI_DIS_S for performance
> 3. Have apps in those guests that care about security to opt back in to
>    BHI_DIS_S for themselves?

I just want guests on heterogeneous migration pools to properly
protect themselves from native BHI when running on host kernels at
least as far back as Linux v6.6.

To that end, I would be satisfied with using the longer BHB clearing
sequence when HYPERVISOR is true and BHI_CTRL is false.
