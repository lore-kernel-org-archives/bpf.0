Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793058816;
	b=LbqFfs3D4wZu7o/4OQk7wmE/fVKKyR6E/cE4yEEnDNErQalG1H+qzWMKMo/pqYibyPM3
	 5Fq/qAOelCszWEuZ6uqGpENGAr+vlveDj2xHHYHYBsq7irzdwU00b5GCM6hT2cujBSV3k
	 3r0KGyFvoPvWAO3bfor9fB0cMcxLcvbJ5c7WTj7yBZbMGaFJzUB4LPCu3aHKcU9p0fBur
	 zSPztRFG88ldbv+DfwT24CkPLdARZ3u8MdPl4mz4fGV7qq/+aSyHPBaXko6XdLxrFclgn
	 IRcXIUbI4KQxwNfxnyr3oL2foz5u4jUz2+N+SJ6jMg09/gjY7SsGSLefRbSl887TuyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 To:Cc:Subject:From:X-Mailer:References:In-Reply-To;
	bh=HuAGWXc3uUnjmcf9NlDKi9LGLS50EV0L01vWrc6DqeE=;
	b=gEZPQ3uEVu8T6N5XmHxmsjU8pT4h7GruoQmJCybn1sktCPLVBkWjUEQJgOr+5Vwu/bBV
	 iUD6QPXoGoNSoFjaqQrAJ6YbdBq/uLZPrnazghrSIaj6JtFsnvfuABX+ZNwiWi4kqCea8
	 v5bf6Yx5BO+9ksymrjdXM3k/InHRFgSwY5xumQfehk/jZjpM3Dwc6paKCKTT+INMHm78t
	 1ZCNougOzcB35LciA8TppwT0WBDSaz/zXGqOj5aBH/KUZ+U49QqO68PrIuDgrH+IBtV6e
	 BSXLrrRHZGoHht6TXenlGHRl7rCa1FZP3hOrViNShVXeQPQKE+eAmLtJn9Q9E60LH8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=STLZP8u4;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6383606A329
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 23:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6383606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=STLZP8u4
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so2357745a12.0
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 16:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793058815; x=1793663615; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HuAGWXc3uUnjmcf9NlDKi9LGLS50EV0L01vWrc6DqeE=;
        b=STLZP8u48uO0oTjsKt7JhMJ+zyb9Ycc1aVx4MomJvE5wisdE+xKkQEfvc6sqJ3tisc
         Mjd5A+KuYelYRR38TfCZj87glN4aHNkBzYORdHooO6kmQUy13UjsZau5IH2Igftk8tiO
         Xwsl2i1MBeegQnsFCmxLHLONTdcTaJOgiPQrlCzbaiu4nobQ3SwB/PalaN8Bc3tvp6Vl
         6wS66OqOeOxNqolboY2YISCZw8ayIcWIGmoKYrPlYA7r5A3ByS+cjwkN/2XVUXvC+LzX
         rD9WJpVxpeJcsaXQMCBhLo8HSvhMKbxUFdTjBtBjPMEWkoVlnOaXuoKZTJsSm3ZrYuAC
         QNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793058815; x=1793663615;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HuAGWXc3uUnjmcf9NlDKi9LGLS50EV0L01vWrc6DqeE=;
        b=m+vBNFwcKwrRNaYUMqtCHlbU0NRVuyLzUsnvxSHtNKx6YdCJ/bAHIddiQF5Z/o/5AV
         vq+44wQaJj5nwWrgAQsehKN8WPVrTAIE/Jou4avw7mHkqVT4VYWrq1AsiTTCWlz5kQs8
         bMP74BFKh2NrrZQ0Ayhi2YQ0L+q/LWUEhnVcQWVvVf6yOqukzG9fk+pwuIXjtyMaW1RS
         FrPOh6EJCgJop+FcIQGe27ZlWpWsnstv2VyHgRQMmliKleshYih5Ga2+OP/QjeqAphUj
         7KtOnQ+F9w0hwXhVPDywpq+Yvifih5ziGOJqjNxcI20dWEJlUrTth1wN/E2uGrcyhPFl
         tcAA==
X-Forwarded-Encrypted: i=1; AKwUvByzOSG2mEyaO1qZWA1o21VXzAZzN9sFYIXGzBgA4Ol2dUrJhtZQq6qRPEMKf8AHCZDLRQo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvgesbg1pbeaJ5dLMLBYNhuPVOvbGb0JVvge7bG/FGqeysukdp
	8xvA+3yXlRBGQO1FU9GlkTY2sGurFut3tXH1zioIDNAmm41850/MA38Q
X-Gm-Gg: AYBFou2J+hE25cB4RIFCFC9G41vEgrf570Bzf49WptfD99c9S7cgCHsiGs76y2Y0i63
	n74GcP2sQ/9NHj42jxlijA0Sw+9h5Y1SL9RtdBPXjGBd3IELYbL9zws266PMLRRFb6cOyKMwNjw
	54LXtWm4YW5ANKTMTVs7a7visLm2iCMIp28p2pMcnmX/ZUqGoEVnDnm20CmdIg2BroArOoiEkeS
	oKbpfxq9Arf+bvzZOB1yJT3cHx1b8HsKrOoTnaXDCOK4MQFzhcgkqCFK16/RFyRk43X/8hYRy2u
	1OPHqA2mFlpSvU5GqYcFLw/Yl+eagvEVjs2HVRMh7xFLNjW7esaQJldCWP4nuiPzFbCx+In7FAU
	auZDHXUmJYRmtYZAZ5KAAi1Gi4Cm+rs6Ahy9ZQK6Twf1fwguli3ArHixSHYnLjH7TOYPfb5LEmy
	bF9jQSqKunoqRafWjYNNKUUZyWqsEb3zIXEBRtvfSOzO1obu+Cfb9IqP91DrFjRLtv52PX3fYfk
	iQrlD4JUwYrMuLfTz3HVrhz5Si63sTIGl0G+vWLrPGBrZpZTvggO6frASWWjf/iry8qHeffKwe/
	A4b/16g3fVvuIWmyqI9tPNxshoXw9jXBWudWM4ewwa7QvrHP5TmztrAgqx6Q
X-Received: by 2002:a17:90b:1a85:b0:3ac:7c4d:8be6 with SMTP id 98e67ed59e1d1-3adead4f66amr6743694a91.40.1793058814922;
        Mon, 26 Oct 2026 16:53:34 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae4064f4bdsm1125410a91.11.2026.10.26.16.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 16:53:34 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Oct 2026 23:53:34 +0000
Message-Id: <DMF6AVOBX25C.28Z0NJS6CEB3J@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>
Subject: Re: [PATCH bpf 00/81] bpf: Stack in arena and a verifier that joins
 states
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
 <fba239f1-febc-4af5-8033-a893f8265191@linux.dev>
In-Reply-To: <fba239f1-febc-4af5-8033-a893f8265191@linux.dev>

On Mon Oct 26, 2026 at 4:57 PM UTC, Ihor Solodrai wrote:
> On 2026-10-25 7:58 p.m., Alexei Starovoitov wrote:
>> From: Alexei Starovoitov <ast@kernel.org>
>>=20
>> The goal of this series is to load Rust programs as rustc and LLVM compi=
le
>> them. These programs keep data, heap and address-taken locals in arena.
>> They use trait objects, recursion, unwinding, and loops that have no kno=
wn
>> bound. The test programs are in https://github.com/4ast/rust-bpf
>>=20
>> The series has three parts:
>>=20
>>    patches  1-15   Fixes and a revert. They do not depend on the other
>>                    parts.
>>    patches 16-31   A stack in arena.
>>    patches 32-81   A verifier that joins states.
>
> Hi Alexei,
>
> Just FYI bpf-ci-bot AI review workflow is limited to 50 patches per serie=
s.
>
> The limit was set as a guardrail for commit selection logic (to not
> accidentally run review for 10k commits). I chose 50 because usually
> we ask people to break up long series into smaller reviewable pieces,
> and pre-singulariy >10 patches series would already raise questions.
>
> Since the approach to patch review on bpf list has obviously changed
> recently, what would you suggest as a new limit?

I didn't know that there is such limit. I'm not sure there is a good limit.
Maybe whitelist it by known developers with commits?
