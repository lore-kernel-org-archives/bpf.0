Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795170242;
	b=EcNQ2rRTDFJovRFwx2jdzmD3Gg0fmOZiJeOJH2cVNMdGNaDua71Gff3JF4f4Olp4nRAu
	 rhOqoscCB3unIk66llAZbOzGLOXuIgGDKp2woPw3kRsiKZl/DTF2WtTz0z3WN6Zdj9QVd
	 oOnLu+JpuGOyv+mXI9YEXHZTcNYqANIyeD8ohozAdKngDaPJNbXBK0IWwV/No22qaaUyl
	 bKU8UdHAgp5aTnJjPqnjFk8Gwni/2CImh0hPLxA2tXKPRU3gME+I6oIc5tG6ZxuJ6qy5H
	 MkDYnBRwN6DnHnidqZe5SNVVTTR99HxMbeSN4VQNU92Vx5+o5gd8qQ0n22HEzh1Ft4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=l8OZaZuTRSXwE+XBNWMHBSQi6ZAfjYJlC0IBxUgqIMU=;
	b=wvi1ueQG34vkpDbsJI3K9/LnpLK3+Zf5kYw1FvQUxaweLkNV9XftAiyGPMFjNmp0z4At
	 ay+8j3vDe/zwYbZf6/RT2YhF+sPchGuUFW+H5NAYtY1g8J2XFUULSM9X5X3WvKQ4WT8Dg
	 mgdYCjShOY9CLvgi/DjNxQLeAhn4ke3uYa3V47Zs6HqcYcIS78+friM0FjLE3zYt414bx
	 WdHPugHejnWgIvBhHpP80gl7vownVRoy19bw2ZyZdqlgl3aWxS6VTFWSUAicB92lAEMAL
	 AuXkV2lm+2gR5kpDDmQTK3WXJB9NcMc/cSlLddYzv4CSWTBcM/tmkntM/iaHkj6yeQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=EnqK7HkX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596DC606A32A
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 10:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 596DC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=EnqK7HkX
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8c700d6cc0bso1084556b3a.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 02:24:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795170241; cv=none;
        d=google.com; s=arc-20260327;
        b=Ij8TTMLiR4YGMfdSThJuEepq3NFLSOrT7fUZeZNGRxDebVnyiW8ik2oFNsJ4THU7aj
         eWMgfEFM+q1ntyiGXr+l2j13IHSXKHJyLHNdxRT4Bx3uO2GsGTJExl39h8ooU2AACEv4
         hlAZGBxtliTWiaeS5FBqjAzpomdn1jpFkCqSW1qq1sc64xltLML/YvI69/dskwSeg2VV
         oBjQjdvYXN9Uy5CpqUP4i+RAbM08ssWC3NQIMtjr5oHK2zgkkRWHZ/ORQmsd1BLzEX4y
         dW0ujhqp6mjQTSHrLfj59m6fV9LDvFzF4tW4XgJDdRVTlw/6q88Zd5lJ+c2ycPH+ow8W
         lE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l8OZaZuTRSXwE+XBNWMHBSQi6ZAfjYJlC0IBxUgqIMU=;
        fh=hfUq3RVHReQtQElDaSw6lKN6amkVVYvc0RxNuxDfLBo=;
        b=OABxtp0+dIfET3BYXpIzFXOE5ylAxrOlAaLYk37iwmt0/NmEhtPAsXalINix4RLq2c
         oTW7AIzu4e53kInEDapgNVNXpZKzKF8VLn8D215nMkj2GGLe5NrtU4s7K8KZ2MaiqijE
         oqhqhDVfxf9MCzheWbgqxT0q2Ib1ZQnQ1sOxqXrk9M5NCSFAQF7llCAN8JnIvq/276JZ
         tENdia3nYNTEZ8OO0WjdT0lHLW45VjxtpBV4mzS5xi7Xkei0lpU4vfQiH4ESm1mUh3tv
         WneKyvaRvBVcO3Z4Ch4fpLn/imnNYKHa//MRIhiJjzfSQHZFEv6vNa6slEC5S/NIJg9s
         ijKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795170241; x=1795775041; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l8OZaZuTRSXwE+XBNWMHBSQi6ZAfjYJlC0IBxUgqIMU=;
        b=EnqK7HkXV4JMkwZzUoD1n9df5Yb4GgrxRydt5bPKL223c8+YcRi15Xt5qGllawfpNP
         muzRUlcsV9WhP3yuhl3CRu2fzIi+TJtoclv1dOsJCcAoU5wRlCQPBDrDEIeX7wW3Q1Tj
         6UWFCsGRstmHBXj6QTM3X71/0cwfaLIkR8MaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795170241; x=1795775041;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l8OZaZuTRSXwE+XBNWMHBSQi6ZAfjYJlC0IBxUgqIMU=;
        b=tXGbM/aqsYrgR96n+6VSRiPteb/h8NqEPTWoK/4wA51/MdQABNzqkeAvIHEx7EDdnJ
         eOFlL5TmXTEt6tVtaquj4p1KQP9AuO3Sdp88b9CWtotPubs2vRDNANNfDVXTsb9lHESI
         ehBb8Ab3zJPb6voiGFKrXC2KTDL8DnEsMOuL8b2993cfnnM4FAlhS35z4XSFJVFRmiTd
         vzpFOLRfFj1xSSzJSlDfcwERM/nqEAavXADzhadse3quhBbsrBqcniTb7hSWtCTL2ki9
         WGc9HdrZl+eRDiL4be+IhWv3CT5BUsVJ+R3b4v0+53rwJraUeaJT9yvIYd/S+CnwkF+U
         uaKw==
X-Forwarded-Encrypted: i=1; AL+hErGUz/sG4U+CAPY7lfHXoJTEDcTUrfSWxUZnmPEbDGqqYjolE0CyPaOaYQCmqW/G4vBEU3A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OYS2RF1YHueslEuu99KmnSxIhq5krS7k4Fc5tPXAp+9RtoQHH
	F9xziROQgWR0CqLkmrtZUep20OojL9UggY57zh+uEMgEwZFg1KCqoB3/qh++itglGpkpG8xGGVS
	CCkljRIFR2+akuxtAhd1sydDsy4+ACTzE+E4Y+G/y
X-Gm-Gg: AYBFou2W16roZToPJ3OAOFMkPl/1f3iMY/7Ae8h0zQCv+saEV7PUE1qaR2sBMic2lwp
	TGquNamsL1FmzTKMBPj0O5mrhY9fd1Zmw6xm4kxb1LDTOp28y6o2dpAQWLqjXKlkhn+SEgy4v0K
	Zo71B/tG36xWOkRHQ0rG6ZkwWBE5Eh4yqYCLURdxnkDLTiVR0oDQqwvfQNJoVI5/6f2uq4hsZHj
	WNlMxW52vrj3QLZQNV9c2DHccBbwjgiOakmaZJGJ+npYcYs/COhvTVzQz5FkGRA44LaubGkzZu8
	pVYeNu8ht6zUv8iwB/l5GxK6oGIvH6/+/BVhMFdMT9CFBeQroRDltluNxXzWjhJCUhLp8bngqAW
	tXYAHlY15WlSX/6FvMXR+9/6YuruWqpB0TT6oBpySS1vNsfTwM1rU9bq6mHCGMGWYIMgg/ksJWg
	Jh7oT+YnGdLm/c0n8=
X-Received: by 2002:a05:6a20:da12:b0:3eb:b2fc:bed7 with SMTP id
 adf61e73a8af0-4014d35aab3mr1802003637.16.1795170241627; Fri, 20 Nov 2026
 02:24:01 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CORE-9NOG.v4.r0.20261116135311-4@mojatatu.com>
 <179511856597.3136.7846835490904436138@kernel.org> <CAM0EoMkppFKECwmjw+E3tWpXEL3=cyg2VYhgpL+StaSiQf+WAQ@mail.gmail.com>
 <DMZJS8O5A4YX.9T2P4DT0DAB7@gmail.com>
In-Reply-To: <DMZJS8O5A4YX.9T2P4DT0DAB7@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 20 Nov 2026 05:23:49 -0500
X-Gm-Features: Aa3M54qRL4Ivjl9xk3_JYL8OAzBjPxDHeKoJxbXTubX9anSYCOsmGEkXxaVdsds
Message-ID: <CAM0EoMm5qit+KP27XV_Q8hHik=KzzHVjSfLDJg161Jyk0xXBZg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/4] bpf: drop the stale dst when redirecting
 to an explicit nexthop
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me, 
	martin.lau@linux.dev, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, ihor.solodrai@linux.dev, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bpf@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com, 
	sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 5:40=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Nov 19, 2026 at 12:29 PM Jamal Hadi Salim <jhs@mojatatu.com> wrot=
e:
> > This is still under discussion with Alexei  - so:
>
> Answering your earlier quesiton:
> yes, a route for A is acceptable on a frame that leaves B.
> bpf_redirect() and mirred egress do that today.
> __bpf_tx_skb() and tcf_mirred_to_dev() set skb->dev and keep the dst.
> __dev_queue_xmit() drops the dst when B has IFF_XMIT_DST_RELEASE.
>
> > I will consider this feedback if we have to resend the whole series or
> > per Alexei's pov 1 or 2.
>
> imo 2, 3 and 4 can go.
>
> So pls consider adopting my earlier neigh_update_process_arp_queue() diff=
.
>
> Need to think more about patch 1. It's probably ok on its own.

That answers it, thanks. 2, 3 and 4 are gone (pending testing).  I'll
send the guard as its own net-next change off your diff.
IOW:
- 1/4 goes to net on its own (Fixes: 94151f5aa966)
- separate net-next, your diff + some comment lines

cheers,
jamal
