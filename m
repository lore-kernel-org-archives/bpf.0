Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D930C2FBE
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 01:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788829483; cv=pass; b=XpbxIvmlYsF0qi0dADJaVsmDjyGUiMHHkOfbS9X96aWkeM8jV8kph0FrrStlhI9JuhdLwMhp42uTS7bgmXsDHnL5vEw7dbmU84PoiEq3jPSSWrR1RCTlOWUcf0wUY7FmQ/jHxpdlPH9BCUp4lBbWEipLRYaHIaSxOps7jXQchrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788829483; c=relaxed/simple;
	bh=W4XdQovADM5RSeHI+/ZuPheISmstJfmeHSEtcR5uyzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptabqB78YNHt7psxZKU2ss/FV9AQ3bgyle/Ta7L3NMCAildTxvqh3UfWWicUe+4fDQSkjByhCL3az3PYqURogoZXiMNKjEpSOrHykAkujc62sDr9yp90piQbJUdMa0FiGb1zSb85/91Hv68/tt2TuomIysdyCZg5xxKPCu59OuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S0MczrWG; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S0MczrWG"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5307425f44bso365241cf.1
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 18:04:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788829481; cv=none;
        d=google.com; s=arc-20260327;
        b=p9CSEmTU2I+mekIN0atDXvjFRGxEnw03SV7rXlsNrKnNkGFj5paIoJV9NZmpZ+B9G2
         exFsmHmfDd9APkT2UYtr3TklVq2AjhMdtAVSVQmdpUv/GULJeprbe6IOye45/oGrmoj6
         W0+fSa6DHHLiIBeGQmZgiSUp+RxK9b8a8BNHp0LeydPZlPWeUIMgCTQXfkyfyi8J2s4o
         VIwNfkLdFfYlXAlQi2KFsrwkTk5Dn7wgieI3K5mPe1MZ5KwIyCgh43IYYuCNAaiiUT0I
         u5BkSqSHEiJ61e+UEUrO/397uSiCzX/NSFRlBuOEkzkL0QAYt8NCdNYgplKgGskDvTqT
         YStg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W4XdQovADM5RSeHI+/ZuPheISmstJfmeHSEtcR5uyzk=;
        fh=r1xbp++P1vjSXe+W+TCg7fvJqlEf+pa4BF0Zr53Zt30=;
        b=o/TNWwwIg24K79jFxed63tUPUF9PMmd/xmtbugd9mCZFuBmPP6Oa0rxgeTX4FXR2lu
         SHwQokwO7eo8pGLt5ePMi5Mtp8JKm9mx/wFrSGm7XxHJXyWEp+o+knCeq4cSntAQhJen
         S7ICh3XybxptDGTVBa3pQOwehcQh5zguCXCBC4n0UvdRsyCwSqeKUn5leB6MqK6Uyajy
         n0CK+5O0+BY5HLSb3/t8y4PjBNiJw/3p3eyy+yXPWGUIoLRpt7p0yk7JCH0MaurROtig
         x7i9Df2HXcxIZzszfzhRUSam0PAqZ3b6kJqMBsyCurjELYsLkNKH5QhAjkK8eOmx40iL
         mYCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788829481; x=1789434281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W4XdQovADM5RSeHI+/ZuPheISmstJfmeHSEtcR5uyzk=;
        b=S0MczrWGpX30+x/4tSE0UhO7/5nIWkmrbcpR+tQLiGy1ecHuzC+1pydZy9SDALW+rU
         cXj7rb/em83lTsyENqxg2vFHRTQ6AV8UJWKIJo3KfoTYwc1YMYJaUwEi65hCN3wNe/3b
         qzsemCnkATfIguMgH0jC8hzs6fOXiXFI67FW/gAE1rF1jXht8shZXpZ+AVg0WFd+w8lW
         GnwY2oPYXN8lXGw7HM4tcJrCGNy4Yw+q2/gWYqephUhYGrJZxvecrpCXWsogsFlaSH9n
         l5x1CEkupBU+lQy9OJgN7x6J6MPkK+b4GSmlSN1ufSnSlmyrTR7pkbIFD2XUrfY0C2g3
         jF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788829481; x=1789434281;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W4XdQovADM5RSeHI+/ZuPheISmstJfmeHSEtcR5uyzk=;
        b=KUerFSug5WfvSOFWXAbV8qEy7pilPDxvBSpEDRECT1F2jpWREdA+ao+6HS8Or5E1gM
         RWBGzeJMTTfaRdl/fEgUA37u2OrPde2os4RzIKt1obj13EGhmNFLqazxEa+38YFcnb+t
         OtKkT0PXl3DaLZNISZZmeOYTRyHZ7INQc496N+F+t0qqF8p7XExQMvZM2iOJ0MLf3S5M
         rBFITJINlR2+aI4s8NK0ZdUdNrMYHcV7DbS1mqMGR5/DdA0AkDQEZ4qJamGej+zD7FfY
         E7DLl/JHBb/TTLsyHP/8UVHCc0suZaVwOZepK6/eWgwHGBC0SPpQyuCHSVfHIeCv16eh
         fZiA==
X-Forwarded-Encrypted: i=1; AKwUvBzQ7zNDvqF5WEN8zeYHilGFM9tP3ARfg1TJQWzBHd611z1Oubx4d8erJOWNHk2J2Kn3Kok=@vger.kernel.org
X-Gm-Message-State: AFuF++kZ5iwgydi6Vwt1en+7Tut2susVhtTrINffZmovmrnirUiDTkh7
	UAnnZbxk+InkDnCw640wIvY41nCSOab4KSMD2VfN2TaNNrEPFTCeMzucEdZtSd00PYW6REPlShY
	CIyyzERYiL/CMRyz+bimI4XL4sS4RRZIA/r+RX0nd
X-Gm-Gg: AYBFou2m9x8f2Jsir/+VpdqH+n1ehs2j9biDOuhEZXE7D9FyAaBE07Vf/r7Egjd799Y
	9ShIaKGJPrtPLj0Axe0+kTQl6k1jzue/A4zQj9h/MY4E8IIHoWroqtCwZFNjbG4S70LAuCp8nLi
	S8JzahUNF11zCF/u5d9fL2YTYRFXaVGGMwWMG4CfbnJK+zSqHjUflXWS9w3BffWhMAgEyF+TL81
	Rw4es1HMtrO42zHQq45OMvFe5tWZS7q7pcj14ZamDJdFFMySpRhARM9SCz5AE+FhslF2PMm5XkQ
	xEm7ZaGSX3ksXwFh7R7WHPJDpraVOWlWqrFveb6rfcfxzpFuWFe85CKpssMy51AyHjwPP5e/M0D
	VjwKVTo0kTibLAWDmI+zR1oxjo7Ot
X-Received: by 2002:a05:622a:e416:10b0:519:b82d:fe62 with SMTP id
 d75a77b69052e-530810b149cmr15210511cf.7.1788829480213; Mon, 07 Sep 2026
 18:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904031912.2133476-1-tweek@google.com> <b965bb62-fcc8-4517-9947-24613650f1f5@linux.dev>
 <CA+zpnLc-WAqE9rA0PsjvOFe_YCZOdVj9YAzuayGXx0nhpqtw7g@mail.gmail.com> <534e5a3b-5160-4619-8b2e-27a81783e17f@linux.dev>
In-Reply-To: <534e5a3b-5160-4619-8b2e-27a81783e17f@linux.dev>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Tue, 8 Sep 2026 11:04:21 +1000
X-Gm-Features: AcwNN1VZYaBih0XkaS7qOeRNbkcxHADyZeWVg_y6k7B5EJaVTTRllbZ02cIFTKY
Message-ID: <CA+zpnLeiZrmvNeatnbA1RSRUVFswXBsJc1S0=mZS6cF_g1UbSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Move verifier failure tests
 out of test_global_percpu_data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Sid Nayyar <sidnayyar@google.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 1:24=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> On 2026/9/7 13:46, Thi=C3=A9baud Weksteen wrote:
> > On Fri, Sep 4, 2026 at 4:07=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev=
> wrote:
> >>
> >> On 4/9/26 11:19, Thi=C3=A9baud Weksteen wrote:
> >>> Commit 4c9241bd731a ("selftests/bpf: Add tests to verify global percp=
u
> >>> data") added test_global_percpu_data.c to LSKELS_EXTRA. Later, in com=
mit
> >>> 1ed2294b31fc ("selftests/bpf: Test verifier log for global percpu dat=
a")
> >>> two verifier failure tests were added (verifier_strncmp and
> >>> verifier_snprintf), both marked as non-autoload (SEC("?kprobe")).
> >>>
> >>> When bpftool generates light skeletons, non-autoloaded programs are
> >>> skipped during loading, causing the loader program to store subsequen=
t
> >>> program FDs into incorrect skeleton struct fields (e.g. dump_percpu_d=
ata's
> >>> FD was stored into verifier_strncmp's descriptor).
> >>
> >> IIUC, patch 2 will fix the issue totally.
> >>
> >> Better to add a subtest to verify both the issue and the fix?
> >
> > Thanks for the review. That's right, patch 2 will fix the issue:
> > bpftool will fail to build any program that is set up that way. That's
> > why patch 1 is necessary; otherwise, the existing test would fail.
> >
> > Just checking your suggestion: what I can do is add a new test to make
> > sure that dump_percpu_data is set up as expected (fd > 0). I can write
> > a new test_global_percpu_data_iter_lskel, that is similar to
> > test_global_percpu_data_iter, but for lskel?
> >
> > I can also write a test to ensure that bpftool fails when light
> > skeletons are set up with autoload=3Dfalse?
> >
>
> imo, the rejection of autoload=3Dfalse prog when generating light skeleto=
n
> is not friendly for users. Users should not care about mixing
> autoload=3Dfalse progs with autoload=3Dtrue progs, even for light skeleto=
ns.
>
> The users-friendly way is to skip those autoload=3Dfalse progs when
> generating light skeletons.

Good point. I agree. I'll send a patch with this approach instead. Thanks.
