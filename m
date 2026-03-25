Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E512E359A86
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 22:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774478425; cv=none; b=Vp4Jmt6sI8dhrcGTEmetdmB+qPMnf7Fle5R6Mz5NUrzHSjyB8udQYIvPZkwk97u7w1EC3aqoAie9dMsXudl2kE0FaQzjfMYWlmYvzYdPcd6PgTTZtMUG/nULOSc8qSmhgN2bY1ek/YgAooWZTYb0oKvKyB3/jpZf1TQ+S7bSYKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774478425; c=relaxed/simple;
	bh=ZaZzTXMztz4BsrTjEetn5WiYeq1UcdFaHBBkV9D77uw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JORF+hsQjv26uktUJKq4jm+6dVNCnKSgpYy91tP/BqXVKxJPYdLd/av/FkksYaNDpCzpzRI+uy7B6j/RPm0d4jX77m39ranWRJLI+bt6eQD3yKeQ8lSFJUSMv3TUKISXzopOgjZYXvDGZs+uP7JSunTSFiEZQQe+EI6HQRYXVRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KF/z/bkj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KF/z/bkj"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-486fe655187so4016225e9.2
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 15:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774478422; x=1775083222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NX3VfcRobzAAPxO9qiWCisTs8vMckyJXXZiebELxbNI=;
        b=KF/z/bkjpjUHw64U3XS+R73TuCv+VhuISeiZNyWCXuvwekFlYSOpJ0rfGo/l9bdSWI
         5vwDZAdMcNnputxdNrUTG6pEKKCJBD4Cvy6qJXCmz7ZBWy27atDhqfyVerDQBwKn7jZ2
         nNUMIOlGseveQBvXrSHJlYCyjmlV2SD7kE+ShvizP3t75rgnteyT3sSbM1NqqXr5WewA
         dxW9nMz3lpOKDPU764Sr5WqUUcMDOX2OczbDnqm16lCyaukE60XpiHrb7ck2EIxi7xUu
         IIhnrWT9icYMgLpeUsnrynAP3bnxRrj7kxAclWHznlnI0RcahBK90cObpnqNaD7HtygV
         QUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774478422; x=1775083222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NX3VfcRobzAAPxO9qiWCisTs8vMckyJXXZiebELxbNI=;
        b=e+E7SIDWMoaZ3Pf8vRKwlSqoood+9f2ikJSfGyKwKOt0p9NY9fIsfEFbNmE/wS9uCq
         DWCquO5+F9moNeCFXXr6krkldIM4huCQqiA5enPfzjJxnYv7Ldj7adzVBove6xOb9BHj
         ABLKFt1E9rvDvlJqCDzVXj8oKimNwbbWWr3DGDj9RnRPmXZ0eBx4nGpz39RSCQCIy9sG
         FeEOXyoedYULLKmLP9MG3Kv2Ubk6G4KLjfbkvcoKUfa7XFXhC/+oappJZsJyjYb3QhX1
         gQzR3FRKRUi4SGg7g97dUxzYDBF2CEfnWoVwSO782b48Z3MyMowmPYWjkLPO+Obaokq+
         A5DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTNqghZ6JvOXDvdxORAwXqZoRX8xawMlDV268qio0mMqTrO9dsqHHGxTxXB2xyXdNvRkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu0HrXc8+lXGeNtum0ykjpBhUa80PV6MfFndzBCQISwqMLAs+6
	AHE9bNa22mdGfQWKbk3cjZl9x5X08mOXexjT/JgnCoQAwe9v5uqEuGJK
X-Gm-Gg: ATEYQzy2MSQMlj1/0LAURToyCn3u7YD0zqN+wTtDH4rAFQIUY/igCsTMgrEkRyNjTtP
	r8x6WsDGAPo2vkWE5icXXDubgoB3D0dXlzkONj8xdfqlYtiCGDtyJDhBNzXLpzZnKB5EOArSiCE
	n7aRNKVzGzGtuiLZ0w0zuEriG1P1WkEktQAzj7jKndc8W1w4juA+iHOLNv4KE0tpf+H7pZ8zfsT
	3mIbU1QRHr+Hh2Zl9Qrl+Q+Na8THIRQgsRnEjlkMV3DAzPigBmxzKJlIpFx+VsQeN3qKgPnbBP3
	plJyJYO2HaO2HkiQWhhf59hZjw4CGTNgCVvRccDhor6KWs5Y52wO2K3cMelKL0VDC6i+pI0zeWi
	nGCVc24QTGOP4Ener2xNaVYN6X6J1NFo7aJqolggECg2Sflu2aL64HhA+gd4pdYP6BgVjyta3eG
	QwZBNkdHHu9w/yXfn/PRES3SwKFEVMo0ko/TQGjZWUyKGhunkeQ5Lo2THeIa6txPeE
X-Received: by 2002:a05:600c:34ca:b0:485:3a27:a960 with SMTP id 5b1f17b1804b1-48715f0369fmr78201225e9.0.1774478421934;
        Wed, 25 Mar 2026 15:40:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487208ca5b0sm5779385e9.2.2026.03.25.15.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 15:40:21 -0700 (PDT)
Date: Wed, 25 Mar 2026 22:40:18 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org, Jon
 Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan
 <david.kaplan@amd.com>, Sean Christopherson <seanjc@google.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, KP
 Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, David Ahern
 <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Asit Mallick
 <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260325224018.34714c6e@pumpkin>
In-Reply-To: <20260325203759.GCacRHp2t8a7c4Bp6E@fat_crate.local>
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
	<20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
	<20260324205930.GQacL7Mp7vwGBKX1W7@fat_crate.local>
	<20260324221308.7sh6afdy6r6tsf4w@desk>
	<20260325203759.GCacRHp2t8a7c4Bp6E@fat_crate.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Mar 2026 21:37:59 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Mar 24, 2026 at 03:13:08PM -0700, Pawan Gupta wrote:
...
> > Although call to clear_bhb_loop() will be inserted at the end of the BPF
> > program before it returns, I am not sure if it is safe to assume that
> > trashing registers in the path clear_bhb_loop() -> __clear_bhb_loop() is
> > okay? Especially, when we don't know what code compiler generated for
> > clear_bhb_loop(). BPF experts would know better?  
> 
> The compiler would preserve the regs. If you write it in asm and you adhere to
> the C ABI, you could preserve them too. Shouldn't be too many.

The BPF code that calls it doesn't use the C ABI - it just puts
a call instruction in the code it generates.
Hence all registers must be preserved.

	David

> 
> Thx.
> 
> 

