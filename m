Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D11C522699
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699311; cv=none; b=u2qr1OWbo7JBTWShv6BxVwe0E9vfxVk1tGe/N8V4X+6XsFdjf04TKhQVZqgtx2ISNEMj8QVvIV/gaLy9B6qEzmIN3NWJ1WyIpBs7QK/rOSr9eNQvjXpKoW7kyOmVyvP99vYSvpVWl0Bwrk5nUItp2F5jRzwwMDTsuOP0hov5n2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699311; c=relaxed/simple;
	bh=xNj28skhAXgmnVsiwfcuNW6CLgzTKZ1pXWol9Jpkmuk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=FMR1Nu226KhwyxNY7Gj6UZ2ZNBSb7EMQUirirnM8+npZOZYN0iCh9bM1gf58VRYR8cg5vwL2dB4ev1TpWBT/UaYt5MwWA+ouLAU8hcPoq3gAhp7QGprbljZOzx6TfgoH9tO4iPwRfa1/VuogD2F7kb3M/4pIekt/fxjzAwupb9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhD91/3t; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhD91/3t"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469f204f6so2142781b3a.2
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 09:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790699307; x=1791304107; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xNj28skhAXgmnVsiwfcuNW6CLgzTKZ1pXWol9Jpkmuk=;
        b=MhD91/3tdjUJl9IUPFfbqqyNK0xlaM0rmwKbxZAFAptTMV/dgnRnWotrAxIRQG8R0P
         19JMuxhN5YMxksR9FtmZy5jOPtrKR4JClYkGL7etOIXzfc1cOMvNiTop1YVaH/sJ+a7u
         WVQrtQBoukQ5vMrKZjCsvC+ZdPzJE6b3kfTinH8X6WQlkARndwfPSCAmlx+1COy9ymTT
         5s0jt84nB9UgJqUl9xd79OAqlcIt6w0OyBrLLvOykkw+LLS6UWsE61rM3xH37EL33dQg
         dO60Aqachs4RAfvf6KKl+he5FWqePPWHPcJ0lNDDzlxrp82nh0knJtYeANONlakLbmuJ
         IF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790699307; x=1791304107;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xNj28skhAXgmnVsiwfcuNW6CLgzTKZ1pXWol9Jpkmuk=;
        b=qMPqB7XLFClBA8ctQzDqvpI9ubq+1Mx/5TUHzuxygOrVen4sD5yQa9BSdwehXTSIw6
         5O1eeQgP7GLqN7AroGQtDawVIMQrJgD/vCpPgzxswJ6tET8ysqqiUSOzbZ1wwvTIK5kT
         W6A5D11jmyyXkWfdOBuK/O2dpdruBJDDy2W7mzhXWm5Z1nUMY6WdGGJZ2r2wfS4Vo1Wc
         KJpgGMCItBezVTsGng0AYr8ClKlLhs8xevKmaRSwfSzZGjleRqBWYfYPWQSPz9cDGMI4
         tv2ufddj60bhQKP1QV9Fsla7iuYR9h0tJs2M2QGKH31gf5jLpGbn/73AaGA45o2QlO2n
         DsKg==
X-Forwarded-Encrypted: i=1; AKwUvBy3wgjWfnvE7Z1Qb5Oz/zcpNfFXA+CWaq5dN8snxDd8m2awNq34H6bo9pQgr+Mp9fih0Us=@vger.kernel.org
X-Gm-Message-State: AFuF++mofIVo+rSX6k/BJNO9x6d1mGbs+ZWxaI8DTEmNaUzNtB3vHTUj
	orsoPg2l+MSV/YfROBw8Hp2glvctjlAZyk9qo0qx7LVkWMlrnExkSh53
X-Gm-Gg: AYBFou08xaWW16WSgcxpFXu/mDc+EV9ww2YJe1oLcFQ5XmjyKaswHwHe2NoLxby6CYs
	dVqykqodb70Zm5C+WD7HUdb37G4i0h4l/tUS8dr3UE1wKOjshMWC6PZbli7Blcnz+Iww6yNbyTd
	Ms6pW1vj66/Beduk5oLJdJQZqaI4BHFOSF+++4r2rQcjoTlNFA0zgjmL/eikT83HogL1UJ+fTz+
	o3H4ontav6dWGORbg45zmkpduZcvt0WatJwIOkT9cj8IkHek/aWUECY9YEDwRlcu3kTMWpQb2su
	ETU0CiLroHfmzv1pp6wLPSCPD3wk9JLkpxKw5lzheb4mcFNEO87ACz+BoF9lLXszTCjDcwB4fC2
	hB37kdHdHxg71gN4oS9rAiA7JwdrfM8+m6r3ZjBtMyxcUMq9UVXUa3zffCeeQro+tc/8ik60+Pm
	62aweGuBFvSN14Wffi7VrDtgwEacUqbCXzkgnrsSV/z7NYw+FqqHX/e2//hYr77YNxnpBubgDZA
	9reIK10WLYAuSny6SBwyJ9SYoPrP+pGKSi2MqcUtnf2Mo/TerdyicyG+zQ6yvGu8DMtExkUjh+7
	HE4=
X-Received: by 2002:a05:6a00:2356:b0:882:6993:25b5 with SMTP id d2e1a72fcca58-8826993339amr6934341b3a.27.1790699307008;
        Tue, 29 Sep 2026 09:28:27 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88685653bacsm276787b3a.0.2026.09.29.09.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 09:28:25 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 16:28:25 +0000
Message-Id: <DLRXXC72E2CS.2MRXIPM0KME7Q@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Puranjay Mohan" <puranjay@kernel.org>, "Paul
 Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Pu Lehui" <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next 1/5] bpf, riscv: Fix stack-passed arguments for
 indirect trampolines
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Pu Lehui" <pulehui@huaweicloud.com>, =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?=
 <bjorn@kernel.org>, <bpf@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20260929083924.1851840-2-pulehui@huaweicloud.com>
References: <20260929083924.1851840-1-pulehui@huaweicloud.com> <20260929083924.1851840-2-pulehui@huaweicloud.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, Sep 29, 2026 at 08:39 AM Pu Lehui <pulehui@huaweicloud.com> wrote:
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Reviewed-by: Pu Lehui <pulehui@huawei.com>

You're sending Kumar's patch, so it needs your SOB.
