Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD8E3DD765
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100293; cv=pass; b=OQwq/C2+U6vd143MU96ZVwpMmEpydd6Dy4HQP77eO69w3yb2eiqgade+8CbhPAYj6cA1Vzx7n22IW8UKUE6VuoV9AwTJy2Z+QP5BbMtk/kpojHfPMdzaWE4CFlaQYTPPLQG3J2uMcxgC70lOnFbgCUJ9ZN9DGAJ8VxBkaFgis7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100293; c=relaxed/simple;
	bh=i278ipBKd9t4eNryNmv1UqNg417NlVEpdzsVGz5SQq0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oe/8vLTH+zpnG4/AXE5HG/iXPC0ZbWIn+16DVjvDxdVm3y8/ZxfexAR13OG7SG4bqd5aJ9+AMleRkiYI4Svnkn3pchWCXzJmwZud5wxo/LEUVL+SCMVw1dmhXWHXH76QKXWQxI9zqpkmi+veM3fiL8d/2toquVumlAtt0VUkDuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dfc6529b; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dfc6529b"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5ec87b1f525so547410137.0
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:44:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769100280; cv=none;
        d=google.com; s=arc-20240605;
        b=HpuUNw8x9ML0VMtR6Jk5et9Q6NN6vyoLKNy0ms1U/3L535zzS/ru8/Iz5vP4l4qLEE
         vbDDOTIohbrThpb4hw5UXIERRG4EOfqd/RHKas9Pw7mIh0dfGBiHZoZKPUVVBSlbH4Kq
         CJdXKeiov5Z/NKJlFozU63SY2E9SbibJnB5Pj6i/Ilxi6W0PXSdsyBCdrYYpgWc535Wt
         XjDhvZvtoX1YjJJuViw6mT8Gk3kaPY+aBYfotw2ZX4mFFND3mIVrmNfuMNb4NHr4c0X7
         PFuzS5loYwK9IKAfwuehHk8RUkgMQ/j0QOTXrgdsyyNWYL8ECWW695ZfNVPLrLk8fldF
         DR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=i278ipBKd9t4eNryNmv1UqNg417NlVEpdzsVGz5SQq0=;
        fh=Yv6QUXSBn3uynr2V0mbr8xT05BGNxNewlk/WeNGgUBs=;
        b=klLMrNo+aco93TrOWmvpX0cXq3HqxW2lxOkCBohpLAzKoRiqd/f2s7g0eJzhY7IZz4
         z3K/ZUiesExJFb2PB73N3YS2+L2wiLuCgjZlRXZ5g1EOnwvY9XkeV1K4lX4b0guEW0Y8
         4QfTgKyX2eF7VRUiNc8zKgKHE+CdgIdjlG75pR6RHjeH5AoeEs3gIZPL6ZJms3sngaTB
         Lg7lMaMJNtqafdqqdk0MHjtCxbDO0P+KkElPKv05TcZK5TRfogjPcsBSbmV14g/OsQs9
         7/6p4ynWqfvNDsiXirCxMNu6XRfFmW5u/PjshxipIGFk3vpmadxbtRNAJOAXeignMv0/
         dnyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769100280; x=1769705080; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=i278ipBKd9t4eNryNmv1UqNg417NlVEpdzsVGz5SQq0=;
        b=Dfc6529bhrwVaUn3YFXZCSUY5JhwdcykntEWmJBOZ5d1M1fQelFtle5XRVrvvcf3f8
         0IdAa02rZxfIuB2X5MTdy4mrRK9HIYUbxP3SVo83JD00f03CrF2HsaRXrLc0lzcAxMmh
         lKJ9tI/YJPfUZf+Lb62z41OJ5CzOXE/zHlooZNpwRkJReZPTPYydzS39pI2u+3RpEEM6
         dlz4xHl1+zCZs8zcO+Wr6j2pPs3Nr6pHtVrUfkvGgGO4jl4qF0Llg3tbd1WXVSVU1ZDX
         9FbtTHTHMcAocczb+axesPiHB/rnQaU5gbmb9JZfdhU3EZ4LWRwMkNmRJIQRlqJyoiyv
         P60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769100280; x=1769705080;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i278ipBKd9t4eNryNmv1UqNg417NlVEpdzsVGz5SQq0=;
        b=ddl++btHULKqrX9qXIFa+P/K7QueaGdbqOiCJl1yGhgSvCHjEXZyDFjaWqKt5h3ZTS
         TjgSvGukj7Go5B1jWmCrtiof9GKMGK6nip5A7SY/9tNER2bKF9U9vxxK4GIcMSuMa9b9
         iB73DHczfmSwcef9mEqnufjZ3kGG9o8DAHECgn65mDMqAopfiWnLK9VZwTiZYR9puORZ
         So7vfr6KQ716AArQXzzQ5Q96m0R54wzF146SOXqYJGig/I6IjknDq4X1Ta7IUZ0d3Vpt
         FI/phK1CpmwUxaLaMi2W2olqKqpUbvpk7D8ObbGdDcpE2KBwaXNvDWhHCWLredzVrgcM
         PSNQ==
X-Forwarded-Encrypted: i=1; AJvYcCURegq0QfxqL8Zkda5Tye28D1TyNmfmJE8ijqv/YKWYURlLLBUdiTRzIC/N4ca2oqaT1Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgkqCjNrMZ3TtaP1Iz7pUh1EaGuwG5qUsIwxs7Dw4HbxyWhIk8
	ratHOIvqcoTRem0sWnu14aObQTbpkxfMPvknSrRPIGxQ8Pe0AZGQo02wAHfix4uZ3MBVq5IAQm1
	2lFIoyLaXTsNwUardxuw0h2IisYbVvlr5k5x7S7K1
X-Gm-Gg: AZuq6aKChSw6eOdqNtQi7xGMkSE3oGPsHSjRZW6rQ7Wowan5gnpn9sv8E1oTv4lwVVL
	dg2597XfSeygEMiRcngprtozALs/p/kTF8om+13yOFxxB33kNXgFpWyfAN1URXYRHnR01CJSRy7
	fQfRsdXHTZbbJHiDWpxSYKERrGJVoEgYfmgey3Ly1K9fqkhYXV61rIzQctXprHm3MxZjy0jBSpN
	KDLryj0q3bKYJymqOlXaCQVtRmnwoSYfXYXw1IAC4/3SPyhztdJR7oRy9TneoHmA3R2Vw==
X-Received: by 2002:a05:6102:d89:b0:5ec:c528:4df8 with SMTP id
 ada2fe7eead31-5f54bc628cbmr124387137.28.1769100279450; Thu, 22 Jan 2026
 08:44:39 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Jan 2026 08:44:38 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Jan 2026 08:44:38 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <8c1fb4092547e2453ddcdcfab97f06e273ad17d8.camel@intel.com>
References: <20260114134510.1835-1-kalyazin@amazon.com> <20260114134510.1835-8-kalyazin@amazon.com>
 <ed01838830679880d3eadaf6f11c539b9c72c22d.camel@intel.com>
 <CAGtprH_qGGRvk3uT74-wWXDiQyY1N1ua+_P2i-0UMmGWovaZuw@mail.gmail.com> <8c1fb4092547e2453ddcdcfab97f06e273ad17d8.camel@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Jan 2026 08:44:38 -0800
X-Gm-Features: AZwV_QjFiVCL1GgMB61exuGngD3MnDbAOiFUMFZ1rYdJZrzTGdTea8E5DMfoinE
Message-ID: <CAEvNRgEbG-RhCTsX1D8a3MgEKN2dfMuKj0tY0MZZioEzjw=4Xw@mail.gmail.com>
Subject: Re: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from direct map
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Annapurve, Vishal" <vannapurve@google.com>
Cc: "david@kernel.org" <david@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"jgross@suse.com" <jgross@suse.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"surenb@google.com" <surenb@google.com>, "riel@surriel.com" <riel@surriel.com>, 
	"pfalcato@suse.de" <pfalcato@suse.de>, "peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"rppt@kernel.org" <rppt@kernel.org>, "thuth@redhat.com" <thuth@redhat.com>, 
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "maz@kernel.org" <maz@kernel.org>, 
	"svens@linux.ibm.com" <svens@linux.ibm.com>, "ast@kernel.org" <ast@kernel.org>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"pjw@kernel.org" <pjw@kernel.org>, "alex@ghiti.fr" <alex@ghiti.fr>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "willy@infradead.org" <willy@infradead.org>, 
	"wyihan@google.com" <wyihan@google.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"jmattson@google.com" <jmattson@google.com>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, 
	"luto@kernel.org" <luto@kernel.org>, "haoluo@google.com" <haoluo@google.com>, 
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "coxu@redhat.com" <coxu@redhat.com>, 
	"mhocko@suse.com" <mhocko@suse.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "song@kernel.org" <song@kernel.org>, 
	"oupton@kernel.org" <oupton@kernel.org>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>, 
	"kernel@xen0n.name" <kernel@xen0n.name>, "hpa@zytor.com" <hpa@zytor.com>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"jthoughton@google.com" <jthoughton@google.com>, "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, 
	"maobibo@loongson.cn" <maobibo@loongson.cn>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "shuah@kernel.org" <shuah@kernel.org>, 
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "prsampat@amd.com" <prsampat@amd.com>, 
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, 
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>, 
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "itazur@amazon.co.uk" <itazur@amazon.co.uk>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	"dev.jain@arm.com" <dev.jain@arm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, 
	"jackabt@amazon.co.uk" <jackabt@amazon.co.uk>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
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

"Edgecombe, Rick P" <rick.p.edgecombe@intel.com> writes:

> On Fri, 2026-01-16 at 09:30 -0800, Vishal Annapurve wrote:
>> > TDX does some clearing at the direct map mapping for pages that
>> > comes from gmem, using a special instruction. It also does some
>> > clflushing at the direct map address for these pages. So I think we
>> > need to make sure TDs don't pull from gmem fds with this flag.
>>
>> Disabling this feature for TDX VMs for now seems ok. I assume TDX
>> code can establish temporary mappings to the physical memory and
>> therefore doesn't necessarily have to rely on direct map.
>
> Can, as in, can be changed to? It doesn't now, because the direct map
> is reliable today.
>
>>
>> Is it safe to say that we can remove direct map for guest memory for
>> TDX VMs (and ideally other CC VMs as well) in future as needed?
>
> Linux code doesn't need to read the cipher text of course, but it does
> need to help with memory cleaning on the errata systems. Doing a new
> mapping for each page getting reclaimed would add cost to the shutdown
> path.
>

Can we disable direct map removal for errata systems using TDX only,
instead of all TDX?

If it's complicated to figure that out, we can disable direct map
removal for TDX for now and figure that out later.

> Then there is the clfush. It is not actually required for the most
> part. There is a TDX flag to check to see if you need to do it, so we
> could probably remove the direct map accesses for some systems and
> avoid temporary mappings.
>
> So long term, I don't see a problem. For the old systems it would have
> extra cost of temporary mappings at shutdown, but I would have imagined
> direct map removal would have been costly too.

Is there a way to check if the code is running on the errata system and
set up the temporary mappings only for those?
