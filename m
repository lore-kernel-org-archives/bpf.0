Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665771;
	b=W65o8mES1ucbturTsAZEx+549MsxwwAY51svweJ6nQQhfstiAXftWcbvlDGatiPDweaY
	 8N14vY/bp+XmoIHBuk1evi7faIrx/Qh4df2GqArZpnT8D8yar/qe9/j/4QK4Eik+JcBsd
	 CLGG0Q6UiMdResMthQdjmrLJC7Pt4Hu3ZcY4fKCDwfLZQSq4rzVU7rt0VgtPQLsHkUleL
	 H33i1+EJZHUQa93Duuz6TX5n2/7HeDniqmVDLCxHBKbZ6k5ioYWHnOpLTpalMHSBAEyfi
	 u0/UgRZIS8a1oHYcL2U6aXvPQTt7n5Fp62ePXYVbwwanWw1Fk3F20CCVAsxK++5YIxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=KymnTEVxZ5BAuDv5SBxrFRjrFFiXjbVePi0WA826tMs=;
	b=iTX/2rjguB37nOQt/629QlE4xq6dLG7pAz7wbH4RDRcvNdmWP3YJ1qUZ3Z8G493IwV7D
	 6s070DLADlk1QrSRd7Z0UhnJ2zPkFAVLirRq1vLZLaz1wr6fsnXxZtHxcQ0c3ZtvZO+xa
	 dNbwafjLXkgGY29O1TW8TSCBHDT8msC6mM/5Jb8ecyEjjpRhJjOKziWYE9NCHc9sNbztZ
	 pRQMbq5HnG7p3PA+Q2sE72iWRS1LXoLp7tosDX5k3hP7SAefbmuJUFlU5ubEwuHymeRxB
	 0Nss1mShxFWj17vyFkwJxNxGSyluD2GBja/wukpx7uSkzndYBRCboCGQEqDO1OiMTPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FwOUZ9JK;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EB0606A31C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 04:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81EB0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FwOUZ9JK
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f04b676219so36907245ad.0
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 20:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795665771; x=1796270571; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KymnTEVxZ5BAuDv5SBxrFRjrFFiXjbVePi0WA826tMs=;
        b=FwOUZ9JKoqmytBai9n8JFknS76YbL135trgL9Tc8USuxoqTwIwopbBDQiXCFbarS3G
         sXwFOrdMqGGiNruUnb5KPkep4aYfsbfD2O91wixLNujFvt2wb4F3KdAwRL7aSc6ZIrj0
         N6J/rM+6NfddaG4fWnJTFli6AcVrLBvDLAIQZujgvJYdw7T3eUY9FgDDeva1MG48fY7u
         7T5h5xLfh6Hylx/ubFkSEGu+O2fcjYTKCf2dbbAAfC4afYjWXTPVlEIo3siBtPX5RpiN
         2NvQy1mhY8Ck/hudb960Qx43En0YIpVu0nAuCHsPata++0C/uiCiHiWOgjsYKHpUettD
         CDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795665771; x=1796270571;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KymnTEVxZ5BAuDv5SBxrFRjrFFiXjbVePi0WA826tMs=;
        b=24ecc7qxXTz2P53Y9aPIzzn+oyfn6O5B4UiqlTqkR7sGxQODPg6Lk3LSvgV856KjCS
         03j4JQOe7MltuXVWHGe1DOCd24MdsFOlNVKktyIwrMbEFawcQ9qgTC+SgZh+sgBh1Vm+
         eXRZqcfE3IvhTOQMeJ4sZaZekA3tmbKkBmK0Vz+KSGLyFTKUJlfq1UfTCLotZU0bTxAX
         odf4cusrZPqlJhGJxiWtvu+BQs1YuOdNsCGm3D9v+MQXaTOGP+lCZsI/u7fZtZJYL7Ji
         EdYTQA87VPYBqCzB1vhPOSj4lYA4bZ+DfuFtnWD/h5ZZSjSkHp0LzIvkvbe+tyf4I+Ch
         u2OA==
X-Forwarded-Encrypted: i=1; AL+hErHk1hpGKTMa0pJvL/+q0q+D4yRKrHub0C9tqy1DqQ45UmMPKMGYhkbEHWMFfyVcc2xR8lA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gtewJxk1NXM+xDeFQcXvXe/jaZbCaLkHXSMj5YJZRtxNan+MA
	q/43fAP+NqF5MlgXFFq8kKSNN9GtsOBzpGNV0DVJJIp21X9F9wxi/CF7Dm8zqQ==
X-Gm-Gg: AZFdTZd+IdlsIxcO7rUUqmRYXP/4EX/+zI740m2jJ/7CuLsv0EL8Jx9E7Ct82KWWfM3
	k97WooEEVuVvYtLab644a+VOH40epUMARZbCr+M79Gja1HOXcBml3pBUsi3qeTvWO/NWPonig9I
	SepeKllwSKICYF6wZ1DReV+pCFbiAqX4cvCrAEoqajvu+OuLUimUdw3RmT+TpCx3o6T5eTUypiz
	5Umds/GgvxSWWPn4KJGp5aUZsW7m+6M5TBpw3E1zW5ZbpuLkbs0fCtKsuaB/qlPc3G5JDpb1Xes
	qZskIMTrkacxKfgrJo1Xd15T9gm4d6bFzTIFS5UcGky9iLVK4+AWZobsst5LJCB5T6ZF2pwNsNF
	627o9dV5/1babOFUiFrwnpe2aTSsdGEhqII331iw9xgpgAZiExs6gHB+Og94WQZoMUTtGHVZyiD
	XPBhjqjtCplgZ55IPUYCQlKPAwn0hPtmWN5ztwhT0Lij2iWd0xYTGVdhvitYgIqrKz+r3yfvg2q
	MwD3831Igi/dqOkQOl8BfCFfMZsLpiM6rWKgve4vKPjqDPaS1oHc36eSbtp+nqslMY5kcv9gzS/
	xr3wO2Y76Jhxs/vnO7FLjAFw25/4DfNgQYb/g13FrSB4lRoS0EtwLll2ebL52uAbUC3o4TQrLUk
	xQkN2g+egyeaIATjooKRd6QMd5hp9M4nQlO4=
X-Received: by 2002:a17:903:298c:b0:2ed:2176:2452 with SMTP id d9443c01a7336-2f03f155229mr202979385ad.18.1795665770704;
        Wed, 25 Nov 2026 20:02:50 -0800 (PST)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f102fc4sm96585885ad.43.2026.11.25.20.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 20:02:50 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 04:02:49 +0000
Message-Id: <DN4UE2L5FO1X.1MKV1JVQWDT7C@gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/5] libbpf, bpf: Utilize CO-RE for BPF
 program parameter presence, ordering
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>, "Alan Maguire"
 <almagui@kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>,
 <andrey.grodzovsky@crowdstrike.com>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <john.fastabend@gmail.com>, <mason@kernel.org>,
 <bpf@vger.kernel.org>
In-Reply-To: <CAEf4BzbkrVyCSW1aRCo_s=2pxK7NRfUnznk21CY4-txqveRcnQ@mail.gmail.com>
References: <20261125165845.45806-1-almagui@kernel.org> <CAEf4BzbkrVyCSW1aRCo_s=2pxK7NRfUnznk21CY4-txqveRcnQ@mail.gmail.com>
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

On Wed, Nov 25, 2026 at 02:49 PM Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> we need to make sure that we can use
> __attribute__((preserve_static_offset)) together with
> __attribute__((preserve_access_index))

Yes, but pls remind me, did we make it work in the most recent LLVM ?
So some sort of __BPF_FEATURE guard is necessary?
I don't recall whether we added one.

> And I'm actually wondering if the better name for this would be
> "bpf_ctx___<flavor>" or "bpf_ctx_args___<flavor>", because it's not
> always *function* arguments (tracepoint, BPF program, etc). Keeping it
> more generic as "context arguments" or just "context" seems more
> future-proof.

I'd keep bpf_func_args___ to match existing bpf_get_func_arg() helper
that reads the same slots and works for tp_btf (which is not a *function*
in your definition).

bpf_ctx* sounds like it works for every prog type,
but that is not the case.

> Also (I only skimmed patches, haven't gone through them completely,
> will get back to this next week after holidays, sorry), I saw you
> mentioned the limitation that this context access can be only done
> from entry program code, right?  I think this can be lifted if we
> apply these relocations after subprogs are appended to their
> respective main programs. Not sure how ugly that will be, but you can
> try that and see how it works (please do it as a separate patch to
> distract less from the main logic change).

Agree. good idea.
