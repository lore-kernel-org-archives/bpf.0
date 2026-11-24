Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551424;
	b=tVm5OnYBcuiOy6rgse+ZvC+EFzmHUWAIRZSKaeTApeH1ihFt23WEH26Db5xnhxoiuv4x
	 2squyAXF/LnlL+KInJ/MesxMhdbAmnha5y2uFcxtKbf+A8Sw4bnD9DI08bmraDrMuFTcC
	 DvvwAVKedDrXZfAmkzygqnbw5E+KODuY6Pzl8Ik+oO+JZdM9SQZsuDAficNVO0rK2F5PT
	 BWq3JonenCB4b5168Nr032RT5suIWzincbtAzA8x+Rs87oeU7SSHG47R6ZmQidV4iBh6W
	 9dnY9HAWyQ0czcHA2FhBsb1wIg1Znz0EcnB6xt2fQbRfEkK4k0OuLS6B9TApj3J0u8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551424;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=19rRlZPT1LVmqMdWRk6gML8eP6Esmj++HIxjdU6f6nE=;
	b=X9AGuTkTmnA06LxFqTaL6oOpmUQfj6CkdCGg9LHu+eI/BBzrq7Bn9VPFCWnHWFT39Ej7
	 I+5DmEchd5QUOf0GkBDHiXgqNIN04eLcFDB6FfH3n7IY2CojBMjDxpu9kCFdw0p0Rwsnr
	 96owpXyhWM53RsmNuM7U8F/jDuTqPg2zfaUBEYAcHshtD6LPKGFjST7qWkW0oNqLg74dF
	 iD0xhVC5Q0jrAvUpZqrxH7cfhT5x2Lj9Kvgy8wDPgvx5EFvaq7GUNDKjE55VYHAHuTpEP
	 xDr08wLp4dcoko9EVVe2edND71FOYSiTQ0vWaDkgTEF4moQ+qV3o6tIiw5kag+th83A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bg+8NGH8;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE16606A327
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 20:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFE16606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bg+8NGH8
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2f046b0adc0so26933445ad.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 12:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795551423; x=1796156223; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=19rRlZPT1LVmqMdWRk6gML8eP6Esmj++HIxjdU6f6nE=;
        b=Bg+8NGH8bdD517brgNx6BmmvHoIJvf2qPj8L84H8t1SkQUuzHMTixOn9GZqTfbiWd7
         JVmtTgivhGJrT+f9aYNpPEF5TBduBrG5120dkrLfKt1263YMM84lTX9A9QKMtAECI2+S
         T7+FUFm2fql6mTt404hQS0usO+g2vGaui2neZLRC3bdOia9CFtWRDGtmxe/ugRTgYoLD
         5lCIQeuUAhk9pK6x7AUYPuvq6EQ+V/WbS44NKjN8f7dYT9Kz5XFtd9rm5fEKxTnFozi+
         zWfeUn/b8ZWj3Miny40ImzrE4wcH5olhqXfMj9bgnUexSpNLVKavzcnXHKsDcIXIkusV
         vrBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795551423; x=1796156223;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=19rRlZPT1LVmqMdWRk6gML8eP6Esmj++HIxjdU6f6nE=;
        b=TUuiu86qYgrsFb9M/19B99PP7Xh7hUPRNjU21OM4zPniqabBXEwYYQ7b3+NZVNHXKe
         ClEYY+18BBK4GXXc6U9hkuxQrPgbFZq4g6jLes7eV/VkjUhRuDPrwGfVVVZ5uFaHAIM0
         bI1EYLEkgE2MHWLNnEOG8SD2Ol/AuYGNb9qxyOFpHiz2IfjhUmGeK2s0NPIg3gluYEiZ
         2yBHXJnJ8O6y65qZb8nrjnGWozD3wQ0HBIAj1CPRkzrnFkYkYCQX5Vs4MhY3E7EtIrPk
         I6sv5MA4NZxlr0ldEelI5cgGx/w9iw2ctDv1po6TWX6FphpAcQJbv6UROuhH7zgAd2s/
         Ktiw==
X-Forwarded-Encrypted: i=1; AL+hErE1CP/vlhCR/wJcX/Wt9yQOE9HTDe4iFiPdqJ+cYGUhDdXo84CZCoLNdRerQoNUQXsMrbk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/QvoJLnMqurQrY5K3+Eseuh9NHYU4912L9frvhNQ7w070J4jCD
	S2KfNs7fhtWS6n0yXKtvZ8v5mXrzTlyg3DdfTBwmunnKPUKmKsI4gUFo
X-Gm-Gg: AZFdTZewMsIKmhkNZJJLUIybNRS1FLNFyTKpT1q5uoaIRY2UPboF+/F/RnCdTArcZmQ
	hNADJ8BLkIdfhS9tUhLsOf6SiYiFSqCa4A6zLPCeNYRv9dkZUEYu5Vzo2AQnwM0dnyJ/NKoF5hV
	bm51BWiIJMeMz7Byls/XG8Lc06JJDZBWMksTKBSk07Gs6Hl8bU4fsy3Tks3InvT8Saajby+IzBj
	IWHhXB8dIq7T7c1TV6K27V57w3KN8+jhfH+DlWqObDMBDB9WFkEuSEHTvgJEWB2brZsw5BsGyAi
	ygBRBDIxoZxT1XMayeFKW4HocMqIbzzd3/AtjisBb/bvkrstBNIHfxvvG05JZxzNN2bsEyudXaB
	MWo7bayJtHQMLIlkTvQCUBAx42NqerkC3jdc+Rf/fzXyYWhzPYPhZSHIBopMfsJH/ydm0kVlIMi
	NtG4ILYr77uhuOqYHKQlsznFZ/72fTAog1/3ebfnn2hCgG2j2JaoAz3dk0hFGg+/7qBmgEaiKSp
	/6jZ/eU1YB2I6WBKJDqnrDjBXIFnzwrcqVl71s89WMCSKqYrAYUABOM4aPqSm+smXP7yqpCQsqR
	duwFNMQsjoHL/oA8qlkT0x/4BjEb0g1iOih+QpuG3yDXAU24iZi25SvIKLuzxgtZC2ec6KAdZuy
	TuYzSTUk5pJYIQnOAGjglwyV/xKSt5w36YQ==
X-Received: by 2002:a17:903:24b:b0:2e9:9bac:2e90 with SMTP id d9443c01a7336-2f03f1aa1d0mr135413125ad.65.1795551422519;
        Tue, 24 Nov 2026 12:17:02 -0800 (PST)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c1a8asm73930925ad.24.2026.11.24.12.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 12:17:02 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 20:17:01 +0000
Message-Id: <DN3PUVNYI5U3.EG46DZP94II5@gmail.com>
Cc: "Borislav Petkov" <bp@alien8.de>, <bpf@vger.kernel.org>, "Puranjay
 Mohan" <puranjay@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "Andy Lutomirski" <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, <kkd@meta.com>, <kernel-team@meta.com>,
 <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 1/3] x86/mm: Resolve BPF exception fixups
 for user address faults under SMAP
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Dave Hansen" <dave.hansen@intel.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
In-Reply-To: <077779c3-aac7-49c5-8887-0d4266caa2d6@intel.com>
References: <20261009024925.3169077-1-memxor@gmail.com> <20261009024925.3169077-2-memxor@gmail.com> <20261009041346.GHashp-hYpLl-o-l3M@fat_crate.local> <DM0ESVBT9553.2S1RWK1W7M8WW@gmail.com> <a08e55c4-26dd-4502-9cca-b063387a0e06@intel.com> <CAP01T77AiqVjyTJbHYqXe2v_h+PYzFEe3DeVTc1nyZVnzOfd5w@mail.gmail.com> <077779c3-aac7-49c5-8887-0d4266caa2d6@intel.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 24, 2026 at 07:25 AM Dave Hansen <dave.hansen@intel.com> wrote:
> On 11/23/26 09:23, Kumar Kartikeya Dwivedi wrote:
>> It would be equivalent of doing copy_from_kernel_nofault() in the
>> normal kernel.
>
> ... and running afoul a userspace address. So, no, it's not equivalent.
> These accesses are more wild than anything else we have in the kernel.

copy_from_kernel_nofault() runs into user addresses too.
sysrq-t does it for every idle kworker in print_worker_info():

  copy_from_kernel_nofault(&pwq, &worker->current_pwq, sizeof(pwq));
  copy_from_kernel_nofault(&wq, &pwq->wq, sizeof(wq));

An idle worker has current_pwq == NULL, so the second call gets address 8.
That's the same walk as sk->sk_socket->file: no locks, no NULL check.

The set of addresses is the same. The difference is who refuses a bad one.
"CPU" is a fault and a fixup via extable:

                              user, guard,                  unmapped
                              vsyscall page  non-canonical  kernel
  --------------------------  -------------  -------------  --------
  copy_from_kernel_nofault()  compare        compare        CPU
  PROBE_MEM today             compare        CPU            CPU
  PROBE_MEM, patch 2, SMAP    CPU            CPU            CPU

Every cell ends the same way: no data and no oops.
The series changes one cell.

> Do we at least require that these super specialized programs have the
> bpf_prog_info->gpl_compatible bit set?

Yes. check_ptr_to_btf_access() rejects a load from a kernel struct in a
non-GPL prog:
"Cannot access kernel 'struct sock' from non-GPL compatible program"
The check right above it wants CAP_PERFMON.
It's the same as bpf_probe_read_kernel(), which is gpl_only.
