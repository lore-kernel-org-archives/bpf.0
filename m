Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C1926ED3E
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 02:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786588668; cv=none; b=j9KngWM8fZAcvOyRVByN4vl/8dYHXo7hPl5h7MDZLXYQQ0i4IJFHDlOFYz/v7VMV6DqTn8f58ojoeR+aUmzKHhJUWV7wTKI/gBLP3SqARn9a+MaI+1SDNz224ZCGE6TMjJ979Nl96c4Kp8g4Ryt9c3InHWFXX6Bqw5tgiyHLLQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786588668; c=relaxed/simple;
	bh=Cp/7r3UqGsO/nzKRlaWKpWO+vM+tfG8GSAcYl45XzRk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DuNYoJpnCJ0s1P11vdxuse8WpLS5lfI1Feb3dqQtjLrr6+uud1t+xYRFXQNM5rJKhMjr2JE4/o6e8BLhM4tBNoamDBnsjYzzRY0Eod0Tb3B6zT1cgfmhrpt2pKTtbFfeN5rKcW3Sb8aEQuOmFPgf08qLgNWw/fd33CFdmYPGcSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ea3y0Uxc; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ea3y0Uxc"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-498079e98beso3613025e9.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 19:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786588665; x=1787193465; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Cp/7r3UqGsO/nzKRlaWKpWO+vM+tfG8GSAcYl45XzRk=;
        b=Ea3y0Uxc3YytxauolBWgCKKYF4jq7xX4raO+F4/wSIMC1BXmwfqGDumP1wdLQM8Y9Q
         OL9s7wXL4K6ygZMzksGLa/LCqPy0YDrtAzfKmCyIc6qYt/kT5RgbkA8cnVkPr2MDepOD
         ilVdjBvsLPlcGFGkRJWyQkiPgfv9Z9C4z6xNWWCgT62JfPXBa3Jk/dCoaNol/nNXwJP9
         atR4RSQQBcTNewD6xtWWSKgLpyJrMWRaYPF0ICuamWrW3rbJIX0/DleCk2doE6RjZrYs
         vt1wfElE4qVzDM77fy4crHKyfiD3ETRXs+gzRRBVTkFz60cZ/SfbvUS0aQIEa/lNX+6j
         vpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786588665; x=1787193465;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cp/7r3UqGsO/nzKRlaWKpWO+vM+tfG8GSAcYl45XzRk=;
        b=d8xnNKwka4gRJpfb3+LbNVTuocygY3vHpoahWsDyowr7yKZusO12LryZaEO2xI4R1Y
         ChYlDUqUGEfshISa8FTqzvk2gXS64342LUgipMijgxnDb06dssZ8sDD3jYQhnaog/sPz
         h1DBCPQN2AjlxH+4Ht5Y/EkB2N3eCTujXgJ5rKpCvZ2++axsxJp9xnqTbAnXVgwJsSyD
         y8I2pKdW4LK5i4eEjE37/zFvmhb0nTnHnGEVYBU7cSqAVT9uHjknj5jaAbrIw+YW1RY4
         NTTGcGFDp+rOsZxBGTEB2pF5SELbdMIgHfzdMTSvj+f7vXz1HjA/f6l7H1DzUJxAAkju
         ryGQ==
X-Forwarded-Encrypted: i=1; AHgh+RphVFjGpZk5dbABv/kA3QtuGB9OVj9vKuDOECbF38Ip6PQFFEtCv+07A0ZQGjUH6tv7FGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjL3LndXsX1s0miAHu10z6cAN5iXqygYo5Eu27B0ZH0q+MPGra
	/PjvreerVpsOPlH34yMMQAw6qEYSFQzN3AChyNVvHZosnoqPTwGARN1v
X-Gm-Gg: AR+sD122A1k/V1fhCM0ZP7VfofeckDA/D5GXWLXhw3O77daHVog4NN52FL3rjpE83M0
	WSYPbMCWClzhcu0OrDH9INlfEgrX6G9w6ixChDA4R3QLYKwqfA0Tb/EmDk9w7UbVeDAZ8HWs750
	81xEi8DaLka/H0znDG1gTdBcgqAkz1A/ryej+MMdkro0GxpTVa7yfJL9TtIPBaHyN98amYe8vA4
	PIvrE8xPl3C1ZZ6btbUZb/oQxuPTiOK6n3pjlQnmTKGh9nCv4DzsxV8Cdan33llOuUTDy0dlP+f
	pgDNjdVG05x+zTDn4ncHciLziInurCYZ/zKH2RX/TD8kcMG6f0LENykDqfI5/5qT4QB53pRcNs4
	mDieEWGOfiOuN4QiedRsJDIREZnlPDCJPwJCa6LFsMjBAkpd6Ne7Bosm5dYx3Lxio+Pd3rVB5JE
	tyaPYzyWBpg/2nYKpOQXvCCco4bnMWNG5ewlWt5GmiLWRFipjWdt4/or8caMhBb5mEUKqgh2RKL
	sTpbErOost55pAeYTqoL1jfrndi9sZHG3Uao53hoWcWZ2jWN2XbwZRoePCu016wFXGLGoRWeuR4
	hN7LA9rTw/6uN0AIyOXf0fneFOw=
X-Received: by 2002:a05:6000:2505:b0:47f:e797:41c8 with SMTP id ffacd0b85a97d-48159ca5d62mr2939768f8f.4.1786588664987;
        Wed, 12 Aug 2026 19:37:44 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5b6616sm2217698f8f.25.2026.08.12.19.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 19:37:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 04:37:43 +0200
Message-Id: <DKNGTPM2RNL9.2E66H1VIT9RW9@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Anton Protopopov" <a.s.protopopov@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Eliminate dup/restore of
 insn_aux_data
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Xu Kuohai"
 <xukuohai@huaweicloud.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <cover.1785240296.git.xukuohai@huawei.com>
 <5a4528f019c8d2638c019a2f37475cccc16a9503.1785240296.git.xukuohai@huawei.com> <96eceba605b2cb7e93b3e33abf545a02c4eeb1cd.camel@gmail.com>
In-Reply-To: <96eceba605b2cb7e93b3e33abf545a02c4eeb1cd.camel@gmail.com>

On Mon Aug 10, 2026 at 11:17 PM CEST, Eduard Zingerman wrote:
> On Tue, 2026-07-28 at 20:25 +0000, Xu Kuohai wrote:
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> The dup/restore of insn_aux_data was introduced to resolve the
>> inconsistency between insnsi and insn_aux_data arrays, which occurs
>> on the failure path where insnsi was rolled back to the original
>> state before constants blinding, while insn_aux_data was not.
>>
>> After JIT failure, there is only one user, bpf_clear_insn_aux_data(),
>> that requires insnsi and insn_aux_data to be synchronized. It accesses
>> both insnsi and insn_aux_data using the same array size and index.
>>
>> However, the access to insnsi in bpf_clear_insn_aux_data() is not
>> necessary. It is checked to skip the second slot of an ldimm64 instructi=
on,
>> whose jt is never set and can be absorbed into the jt check itself.
>>
>> So remove the access to insnsi from bpf_clear_insn_aux_data(), and add a
>> specific length field for insn_aux_data to allow it to have a different
>> length from the insnsi array. Then remove dup/restore of insn_aux_data.
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> ---
>
> Hi Xu, sorry for the delayed response, the patch lgtm.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> ...

I applied this one for now, thanks.
