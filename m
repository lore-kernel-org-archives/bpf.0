Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB781E98EF
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 00:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769560149; cv=pass; b=TL6avMLFA3EnC7CyLTEm11CIkT+bNkoNn6tT1cGCaxPPh8lP/OowlmzHOp5XDQCJnrztOW6EUtAh2eiPRF3x9xFEZTLTrqZ7+btD9+nj/wVt7ldz4KEBZ+8HvkGzEyRMU/N2YnkEfkjxR8z6ol+LNHEI6KMHXlUv385JE17dY1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769560149; c=relaxed/simple;
	bh=afdfdT2YOMsD0iZJQSrtAQ+axiAIWjxn1C3TT/YCmDM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZyFzONxJ9ZwM3VUwWoUJUIpHwzCJ1ix74v6d5mQr1wDBI6NQKftIb59tAy66L7J3KPFVaU79BmIHI+MFGJ8lhHDAlqdj3HSZU+/BKrYCikz3SnTHglvS48c8L/IWYl4JPq7LUAR1SM45zD37O9LTl0Oyuh3sq1vBRKae2Mr6TYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RoTkF48w; arc=pass smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RoTkF48w"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5f53021703aso2151848137.3
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 16:29:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769560146; cv=none;
        d=google.com; s=arc-20240605;
        b=B23UYQ4BeQErG413FNRzTCD4yH+64AcGgcflMq08oyPBu/daX7odd1VhNdQZnXzdv4
         Vt2ApAeR0jSDhR3Twpih5vXcS3RARLTmo+DXUL7kAdvCcxGAMUThKPg0+OzUW6H3P1aX
         dAokS/1zEjh0mFHRnVGVUW2NtulFC7GmXZIabZz3yDT61nZq7Bprm8btvvB4UYgOu+50
         Cu3AQ1aMYawmu34r1GQy/Wo+pDTOiHRI8VMJzuuJgZfsjL3gAwbO+MrM2OXl3rbVA/Mw
         PJDy2W5/x4wX4S4ARlHVgdRH9o+waV4SpEUzZHngXccgE85C7ngenWQj2OLRZPVvZDcL
         EOlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=afdfdT2YOMsD0iZJQSrtAQ+axiAIWjxn1C3TT/YCmDM=;
        fh=74L8TWLwfii12ORhqUScYLvRTGxDMF14E4U/RmLMVeI=;
        b=LeuwokSqWysggUlVCT+GVFVCE1E28ZoshuYotIBcNbKjdW2dbM8CcIFH/HqJUlgsoY
         4y1KF1c2U81D3uvgloB9JXy7mB1By7uWpvA6wkB5NwC7K9a9AxPXpOwzf6pasw6NncjP
         gLLgv0kD1sl6IyJiNML5NThHcOxBhzJlJfYHgRSW1RGOU0Jhp5+t69xmmYAw90fmIsS6
         ctFgNpg2vB6AHAg+PZEG/I3b2Zp9RSjzMCFFsvbJKdN0STQ3aVoIsCSS0uF9SHwh5wyj
         L376NY0/r0+XGz1xMWC/QnWUKiRTz8QHJPbkJP4G2x8l9GFOAYR9hRdCYcPeF/8U3Ha5
         LmaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769560146; x=1770164946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afdfdT2YOMsD0iZJQSrtAQ+axiAIWjxn1C3TT/YCmDM=;
        b=RoTkF48w++rpKI98DbFbYQgosbq5Z9QYSnnq2r0pJkWKQL7IXk+tBiTjV3OruM/GGg
         ODyn1mmKK+G87tX796IdJALpF+WQsSR4L1Vxu5SJc+ZvRFEwpfNQRL3hcRj5/OEI2soa
         6tWPkr57+6vqerzADKUP6NUF13qgXMGoptBRWRkx1Ax6eUQ6DQwyvVYbU3mlNTlofdzs
         HUJH460iLD2dejAHI07YqaoXQXLkT5ymt+DtUkE7p5CWNgbbwZpBXSjB8RmKNABMm+sb
         ALXGe3FrNfDccfBmdSvM+tZA37dZs+apXke4UFlxZ/l3FUpPzcVJTVRjdqdDnck/TP4s
         kwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769560146; x=1770164946;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=afdfdT2YOMsD0iZJQSrtAQ+axiAIWjxn1C3TT/YCmDM=;
        b=jOqtqs8pa2RNGFqSiWVoi9ab4DiLeGp6nUu7tIjzltmvBxeKW7E7q6QXJSUbd3BtO7
         2lS8/85xEH+bnlgQlX2mgyJKZCVSjNCktdUzXJd1pz8Hr3lCQDEfurfgq6bTpX5Spgtv
         XZdElQNoG8IPoAKM3MGRCbvpwnZljFDkJMery0lsh5tjHjqf5hyd2qAgXWdUZm087JJx
         Gge9K/0gJzLFll+2OTnaduHA5OX7tSfxCl8t6faf0tQ7b6MOhyhnBMmF5VwHSsmlsTFH
         1t8VytNXPeXb/0gWtXYIiz0ERM3mr+RFpaWd7JGv8KTg14b97Vg+9He61kZkrgGezhMd
         mDwg==
X-Forwarded-Encrypted: i=1; AJvYcCW4kAA2Ybkg/Vc8/6pKIsIVwybj44dp7SraM+zOYI5iI/SNiO3Ue+4sgJ5CnFSVpmVg4Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfg73tr8xbZ5MzEfMN5kjfqI4GQHF19Tqapw8SsUcsDepM/lor
	xsgR3R+7KlwYpHU92sXssrDgG7O0xJY77Mx7fgFboOCTzEUCBSrVk4P3fDluH8MapSOIp4LngK5
	6f9sn8mKJGEOCN3wUc8zD6pLqAjl1wYqG7hrDqoSFk9copEdU5b0ieO37d3I=
X-Gm-Gg: AZuq6aLaEHPGmRnXgOVc1qdqa56ozVXB+/i4OiAG7V935o1jle8OoO8rrPo90l8mmC2
	GObS5I7Zvc2OSnlV7aVryqE6oKb8q+JX/BvN7DpgVIhmMlWbqM42r0GkoUNURNQB1/gQ+Kwj6Lq
	PwJUcOTUAi5XQBehw8fS8P6ZKt8GxAWyaEoP+7DClDoL1e4JXPbWvTRS5nYhXeBFRJ6g6vKsW5x
	UGOkNeF8uv1d0G8uSNjPy2KGeXxnQ9Ta6PiYFQcNl6IVQtSLPmK76C2DWyaT/tD8IbzsYRfihh5
	Hb7x0oB08YeT+dvXrdBVnWppaI0kcunj6eAt
X-Received: by 2002:a05:6102:94f:b0:5db:cba0:941 with SMTP id
 ada2fe7eead31-5f72380ed5bmr1335024137.38.1769560145803; Tue, 27 Jan 2026
 16:29:05 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Jan 2026 16:29:05 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Jan 2026 16:29:04 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <f4f2a0297e38ac45e4438342ac2c882b91544acb.camel@intel.com>
References: <20260114134510.1835-1-kalyazin@amazon.com> <20260114134510.1835-8-kalyazin@amazon.com>
 <ed01838830679880d3eadaf6f11c539b9c72c22d.camel@intel.com>
 <CAGtprH_qGGRvk3uT74-wWXDiQyY1N1ua+_P2i-0UMmGWovaZuw@mail.gmail.com>
 <8c1fb4092547e2453ddcdcfab97f06e273ad17d8.camel@intel.com>
 <CAEvNRgEbG-RhCTsX1D8a3MgEKN2dfMuKj0tY0MZZioEzjw=4Xw@mail.gmail.com>
 <ee9c649eed3893d852c3d20fb96bdc4904b7c295.camel@intel.com>
 <CAEvNRgEz0+ic9uvcsWYqWgR5EV=TfY0SAGC39zAL+n19SoBXmw@mail.gmail.com> <f4f2a0297e38ac45e4438342ac2c882b91544acb.camel@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 27 Jan 2026 16:29:04 -0800
X-Gm-Features: AZwV_Qi5-DP-v6wjOnL-aDMsdDCx4XY7-YGdXQ0tP6_jJk0lLjibrIAwkazF3pk
Message-ID: <CAEvNRgHMOWfCRnkx7YJoAzNpBBOHCgvR5GHe66uHJX45WDT-YA@mail.gmail.com>
Subject: Re: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from direct map
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Annapurve, Vishal" <vannapurve@google.com>
Cc: "david@kernel.org" <david@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "svens@linux.ibm.com" <svens@linux.ibm.com>, 
	"jgross@suse.com" <jgross@suse.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"surenb@google.com" <surenb@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"riel@surriel.com" <riel@surriel.com>, "pfalcato@suse.de" <pfalcato@suse.de>, "x86@kernel.org" <x86@kernel.org>, 
	"rppt@kernel.org" <rppt@kernel.org>, "thuth@redhat.com" <thuth@redhat.com>, 
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "maz@kernel.org" <maz@kernel.org>, 
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "ast@kernel.org" <ast@kernel.org>, 
	"peterx@redhat.com" <peterx@redhat.com>, "alex@ghiti.fr" <alex@ghiti.fr>, "pjw@kernel.org" <pjw@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "willy@infradead.org" <willy@infradead.org>, 
	"wyihan@google.com" <wyihan@google.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, 
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>, "jmattson@google.com" <jmattson@google.com>, 
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, "luto@kernel.org" <luto@kernel.org>, 
	"haoluo@google.com" <haoluo@google.com>, "patrick.roy@linux.dev" <patrick.roy@linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "coxu@redhat.com" <coxu@redhat.com>, 
	"mhocko@suse.com" <mhocko@suse.com>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "song@kernel.org" <song@kernel.org>, 
	"oupton@kernel.org" <oupton@kernel.org>, "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, 
	"kernel@xen0n.name" <kernel@xen0n.name>, 
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>, 
	"jthoughton@google.com" <jthoughton@google.com>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"Yu, Yu-cheng" <yu-cheng.yu@intel.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"hpa@zytor.com" <hpa@zytor.com>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "shuah@kernel.org" <shuah@kernel.org>, 
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "prsampat@amd.com" <prsampat@amd.com>, 
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>, 
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>, 
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "itazur@amazon.co.uk" <itazur@amazon.co.uk>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	"gor@linux.ibm.com" <gor@linux.ibm.com>, "dev.jain@arm.com" <dev.jain@arm.com>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "jackabt@amazon.co.uk" <jackabt@amazon.co.uk>, 
	"agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, "andrii@kernel.org" <andrii@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "joey.gouly@arm.com" <joey.gouly@arm.com>, 
	"derekmn@amazon.com" <derekmn@amazon.com>, "xmarcalx@amazon.co.uk" <xmarcalx@amazon.co.uk>, 
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"kalyazin@amazon.co.uk" <kalyazin@amazon.co.uk>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "sdf@fomichev.me" <sdf@fomichev.me>, 
	"jackmanb@google.com" <jackmanb@google.com>, "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "jannh@google.com" <jannh@google.com>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kas@kernel.org" <kas@kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "will@kernel.org" <will@kernel.org>, 
	"seanjc@google.com" <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"Edgecombe, Rick P" <rick.p.edgecombe@intel.com> writes:

> On Thu, 2026-01-22 at 14:47 -0800, Ackerley Tng wrote:
>>
>> There's no use case I can think of for unmapping TDX private memory
>> from the host direct map, but Sean's suggestion
>> https://lore.kernel.org/all/aWpcDrGVLrZOqdcg@google.com/=C2=A0won't even
>> let shared guest_memfd memory be unmapped from the direct map for TDX
>> VMs.
>
> Ah!
>
>>
>> Actually, does TDX's clflush that assumes presence in the direct map
>> apply only for private pages, or all pages?
>>
>> If TDX's clflush only happens for private pages, then we could
>> restore private pages to the direct map, and then we'd be safe even
>> for TDX?
>
> Yes, just private pages need the special treatment. But it will be much
> simpler to start with just blocking the option for TDX. A shared pages
> only mode could come later.
>
> In general I think we should try to break things up like this when we
> can. Kernel code is not set in stone, only ABI. I think it will lead to
> overall faster upstreaming, because the series' can be simpler.

I agree on splitting the feature up :), agree that simpler series are
better.

Perhaps just for my understanding,

+ shared pages =3D> not in direct map =3D> no TDX clflush
+ private pages =3D> always in direct map =3D> TDX performs clflush

(I could put pages back into the direct map while doing shared to
private conversions).

Is everything good then? Or does TDX code not apply the special
treatment, as in clflush only for private pages, as of now?
