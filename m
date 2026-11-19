Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795050587;
	b=sA9Hl7bvkSEGmrV3Cn8NDi9yi8qCCRjsRWAro4vakpNf1yFPJEdhwC+N/bTPNMUsP9JI
	 8xT8EUqE4vj6Vev8drc2mAscg3c3FYVIgfR5g8hUHwY3fRSWG94/QFlNxWMhls+fjknlW
	 34liDxNrVtmDc478XfBd+Z3aS2Lk3Udm9E0ucAaNi761UcYlStTm648oWQOvSd1Xl+M35
	 3nAoswEW8/IbcWklKzPYlsGe8nxw5itLUf0KzKZOOQ7W9FySf6HHmC+uV3v61EoUHzOl6
	 olZs8ELsWrB4nqwmnGTMV20yG4XPw8QEd9aQT5bXOLwUQjqdmeI0ytUX02ZHetksvpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795050587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=kcuwnhHi1ejZNk5KJAve+ceYXe+UhG88RfpMjlvPuuE=;
	b=q4KWtF+NB77fkcasLdTG9EccpktvQvZrzCbWuc+ohf4JBKH263szlwb/yVtXZHRf4sCO
	 GDy6C80avAUYYuzUh9JPJAYswEM9CP8iGNkGpB8ijAHAcXtxl7tMJUqRYgq2uD7kNuMEN
	 ilNGWv2Ht80C/Mh0BI455Kl9/kljeqoSn/A5ShSh/vOmxbD3BpcsWMTV+noIutDgLbENV
	 YdZwscofxMo+pYGTqGooxbN+4EkFr8pz5udjfjcFh+nYjALF6h1xc/7sdatqIloNgfAKO
	 uHJWFleo3OL2IUDaa21bodu23cWiUbK4+dZOLsHX6vJiql+XENcRgBTCSkJ+jhIKbSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xz2pu9bO;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062D7606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 01:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 062D7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xz2pu9bO
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b197cd42b0so1133213a91.2
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 17:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795050586; x=1795655386; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kcuwnhHi1ejZNk5KJAve+ceYXe+UhG88RfpMjlvPuuE=;
        b=Xz2pu9bOIWrU2yHUkSJwTEgeg74shpWpBY509fkvDMTVGTpgDrMPwP7Ur4W83CoQFL
         2zmbBOL1TomMpjwtP30hMAk4TBGTnyfyiATxSGR70pDz05wGATwoDZGNkOwHVnkaoK/a
         UhutV7xB8peHM+lU4rojYWddiF9FOXtBRrgNa6kgY93QrRMwBGsMq9AZrNiWr57c4S3H
         4TFTKO+fqLiGk13K7NIe/fRYYn6zDDsdmJTS6tJOs/7nUYoIm6a+l3N7IXLYHqm2ADkm
         ZjfPTTzvwP+if/RN+WDI80l+0EXE7DCVyV11GfOESBE+OQ5lnKKAUqylvN49M3g5IJEp
         IWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795050586; x=1795655386;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kcuwnhHi1ejZNk5KJAve+ceYXe+UhG88RfpMjlvPuuE=;
        b=WMs36UHNY4ofz0+DzZKE2MpBq50H81qh0fy8NAV5bKEKX/BPYxiGZJxfuFTk2P2tNi
         z/VLn8JIPI5r0Sq9Jq2skmA6ECb1O8LZx/2UmpfGad2/6sCzKDRWPqWaRa/+q/n0qYEI
         Ov/LfrYYy8grloZ/v1VmLJgVU3JJ6yCx2uPqCFvIGr0U89h+pfsNCYM1ZQinC/67UyQr
         5j00EECoH685llXSDmXvIM7U+YYULF7D09yF7+mZ73RVkaEyP9GWlJAMmc69Tf2jMtVS
         3806eDRXfKMqoY6R2237lJLYeJpVYTGIUml3lXPwXDYX38QJREj+mOZjR4l+5ix5R4kR
         y7wQ==
X-Forwarded-Encrypted: i=1; AL+hErG0QcqrPQ/+IOibri+NI5rucz5QyvEhyDBhHV99+ZxpsP//yHmGl4XP5TDPpvKLgw5dWAM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tqg6yswY54Jncmgq6sZMCer3rKxlsgwrtHtCaViIzZ/25AdYf
	vbrQiulemDAXlggL7g71mUiV6eAM7YVclek59dquyi+OXSWO+49jZjEF
X-Gm-Gg: AZFdTZfmyy9bfLWK9KJSIVxoI6RUmv3u/Zxc0MaRr79K4ceInOZiUt5+k6Om+R5FjCE
	mjp+bpJ7/WSRT9NmzpP/K/TMUHmV6MWVBlh67UDvUPMr8FRWSVjO7KfYgDd1wc1tSMYZkcY0Uz6
	ongqH7vce6J4+45geNYAHjmTfNPaK89gSbH6S1SZ7yfj3xN9YqWfNdTBUTkUJK9riSCIlz6QvAv
	DajoL1fs4zk0fDR46pZQLbU7rooUo4USnp5zJy2v/Oy69oiWwF5Y58+36o/d3UXd0SlXMsQCxIN
	eFUO7WiTZoxoFzCJiTycyfABJwR3FhU6pJ/3lc5/jbKTuc0tYy1y45T2+HWFBrhYFOmSE9TN2cC
	hPwlTLh+ce3g+EUbbXdpkgWEnSreyoZKHQiXSvyG7dYQAvHjGEKnHjvMwFJCMpKHUO7iZpoLEuz
	R9HyK3v2XjdkOGPXc3R4aPm9E+L8wENOrpVzPV6qyfzCI8x1fWLeHuJx7PnoK6akSlA1gGJLH74
	xvxN8itRsnOjzNz9HL9n6MFXeId8K5htkB3tI20uUxWmULnlsuIfTiviHK7i6byTyUS0m2CQ3R1
	dXRCFOyqRiXooeAMFIrkNflitrLrxVhz35pF0DA72Z//dMB86tOuyzSFXrpd/ztHIgn3ysoeWqj
	V+QW7TxD3TOhZCeboaSq65Z5nM3QPipqs2Q==
X-Received: by 2002:a17:90b:39ad:b0:3ad:4a8b:c6fd with SMTP id 98e67ed59e1d1-3b3d07a84a0mr4043906a91.28.1795050586019;
        Wed, 18 Nov 2026 17:09:46 -0800 (PST)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b402bfcf06sm89059a91.4.2026.11.18.17.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 17:09:45 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 01:09:44 +0000
Message-Id: <DMYSBQJ585A7.17QBI9XAXAQMP@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Mark Brown" <broonie@kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4] bpf: Check variable-offset accesses against
 special fields
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Shihuang Liu" <shlomojune6@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>
In-Reply-To: <20261118162108.178069-1-shlomojune6@gmail.com>
References: <20261118162108.178069-1-shlomojune6@gmail.com>
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

On Wed, Nov 18, 2026 at 08:21 AM Shihuang Liu <shlomojune6@gmail.com> wrote:
> Changes since v3:
> - Rebased on bpf-next to resolve the merge conflict with ca4395aade31a
>   ("bpf: Walk each type once when looking for special fields").

It's fixed already. This patch doesn't resolve the conflict either.

Just wait for bpf tree to get into bpf-next.

pw-bot: cr
