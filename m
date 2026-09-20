Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9476470EA8
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789924004; cv=none; b=Abcp2dWKVhdsVULQCTmA0SCFkILQf4pWia41fCuWcWXa3JW5D2k4Uu15GN2uFHtcgKLtTMNtT/xvn7uOkWS3pOD2EassFxIMx1B9yD+1t5NlcAZUPVwVnVhTlR36sHMRs9FLQJXK+8G9xdy83qdvP+dOCUcxLhsGMCrwsrZE+Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789924004; c=relaxed/simple;
	bh=anUHqomupBKyPucADmKWr9oN0Lgpc9m6vAMueRhAlHM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=ij9ahJojMbEm03ufN4H/fPxM9tEC/g/qtL6npG873plb9IEBcSbeaDLLhAiZXq5rSxrBa3FliPTKdGbUCYdhqBnD2t4WcTpST8yPPHYS1RIwDUwCK8Q0NJhPui4Lmx/I2aQ0ntaQSiALnsm9Oi8Slv2gUm6Lf5P0Fvb+A8uSsyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nxIcDwdW; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxIcDwdW"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so1938138a91.2
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 10:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789924002; x=1790528802; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KO1TTBeh5iVCqAjmzagpi1LUqmont0PjLJhUCpfZPPo=;
        b=nxIcDwdWDjBJZS9ID3vArupICAVAo9uuDSrADAxhxNFy7Br3c3xfHcCv4s2lW58eq9
         ka7dfoKV3Qm21Ij8lojw5vilLHVik4UMe2ubopT7aDZXzH9pBXNf1GPdHJyNlprfKFMj
         5LY0/j+n3sHrmBO7GfHMrFKQoyxX3jo8MQa+jOgea2rTdW5o/Z50odX+/dCoT5IfJWjd
         BIW4k4P1raSU/506ZdtdXZYKQJApsGpyOhOExFWDPmjDcMvuFJHK8AEnRr+/jzy5cHT3
         o28Y1eeHIFe//C5JFHIbCT0mFYuOraLLo2yeHrED4eTlZRukUknUVy6kFW5UhhZ9JsS1
         PVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789924002; x=1790528802;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KO1TTBeh5iVCqAjmzagpi1LUqmont0PjLJhUCpfZPPo=;
        b=tNDDrTDq18vwwP/0tkAtwBuna3vAec37q3tB2mrGHnxDtANaU8gV3q/rerki6F6fy9
         3/hZjtBwadhfsJMIVjOSLceztsDstu3sxqKfz08c8+3ya8jKyUXSH+9sMP57f199Xmjb
         4yURpb8ihUwK3BAVKi9kqlKDs9yapXA26cf6He9BOrwREI2riaV/gKvwcKcd5vtRit/4
         6x8q6mpsCDLOHQEAUyFI5loPOpN9qYOU6hahNkOKQ67cp6FTgJFXzRVHBDaNPvx9vLfl
         rSja9mj/uVxtr1etqKgsQJKMw4TTm8C7zIHcI9OETYkS1Bfcg2/mznpn0uV62gGX56Wc
         jDnA==
X-Forwarded-Encrypted: i=1; AKwUvBzs0x1ucdu4ECwb25s1U/i57CTcjrDDUUvCWEPHRgT7gQpso3YGhD3PeFlbV9jOLcLWkSQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nB0byd+Ec+ADKlZFfMg22xdr70N0jkBHTscEtaAhI/lQl+AYnT
	a0VXckzWtRvOmGy/I7RUUKszU1NyV8pCLw1yWB4cUR593vjlVnRC2aGL
X-Gm-Gg: AYBFou339Aiw6f5DUeAgDBm62de2npz9y27wF16exZibl3YnzTmWbCU37m6PStQahPP
	gsepVqrmmipOOkx9FZFTK7sfpn4iGSbeTWmvFjuA3jqqoNQiLJCMVWM3hipNaJ+y69GcCzr5obl
	zrZAxxhswezydd0LswWJpbHLyMWH0uM6rzt6lx8N/ILefu9xxcXjf0ukWtKMbpzRYoziQ6FiQPX
	kuAxXgnumBCwN89GVDGbPwwXLNO5c0NW3VrsxFCEb0tr4HbKHL9cVnU6jFuY02WnIN9T/rO+xng
	EDSrGSBaFan0AVq9jlUDOrn/lZxczPNgZW0svmshpQMM0m3UwkgWUAk4f8eT6RZCWma26jl/asM
	8V/mfUTex/wDz321R9VJwmdJm8YzxLpuekYPD4FuAj6UsgVXEt1h2MV95FgM4VOzphj0jSFG3LA
	PQ8Sqjvlk1ac6V7lShjMoT8KJ9XKFg2xZhVllultsFj1PzMTeEFuGxYfkZKKtTH6cqN5p9ZWwZD
	aRWgg6ce6Ryyj0TCIWubuYcplCyJxX2rFBikhcyOO9d5j47IIvE7+qSia2iLibbt5PNhytlitqv
	idk=
X-Received: by 2002:a17:90b:6c5:b0:3a0:295e:6e58 with SMTP id 98e67ed59e1d1-3a0295e7719mr4719850a91.2.1789924002207;
        Sun, 20 Sep 2026 10:06:42 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a038ff8c39sm4175693a91.7.2026.09.20.10.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2026 10:06:41 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 20 Sep 2026 17:06:40 +0000
Message-Id: <DLKB3QCTZH4F.243J1I4BAEBOA@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Peter
 Oskolkov" <posk@google.com>, "Xiang Mei" <xmei5@asu.edu>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] bpf: propagate cb_access from freplace programs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Weiming Shi" <bestswngs@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>
In-Reply-To: <20260920163211.795547-2-bestswngs@gmail.com>
References: <20260920163211.795547-1-bestswngs@gmail.com> <20260920163211.795547-2-bestswngs@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Sep 21, 2026 at 12:32 AM Weiming Shi <bestswngs@gmail.com> wrote:
> Cc: stable@vger.kernel.org
> Fixes: be8704ff07d2 ("bpf: Introduce dynamic program extensions")

That shouldn't go to stable. Loading an EXT prog takes CAP_BPF +
CAP_NET_ADMIN + CAP_PERFMON.

[...]

> +	if (prog->type == BPF_PROG_TYPE_EXT && READ_ONCE(prog->cb_access)) {
> +		WRITE_ONCE(tgt_prog->cb_access, true);
> +		/* Drain runs that observed cb_access=false before enabling freplace. */
> +		synchronize_rcu();
> +	}

tc doesn't look at cb_access at all, yet every tc freplace that touches
cb[] now waits for an RCU grace period in attach.

This is a separate issue from the LWT one. Patch 2 resets the cb after
the run whether the prog has cb_access or not, so it doesn't depend on
this patch. Pls drop it from this series.
