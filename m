Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B1B2C032C
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345821; cv=none; b=agjV5vZUHtciI8fwkyZPBJ1JJVrIUrA/xv3t202V9LW3ifUrk8KPziR+EvfNcpq3bX7dI7DsGvARWOdqofyf2v3hs7T03ZFW1HflNZW77DrsUpUAb7XhVV7wlVh6kyqnGhdFdPAIdEpNkzyAeDGr0IgpKG3jT3YJ88pFc23mQng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345821; c=relaxed/simple;
	bh=tD79ZTMBx9mYEc+sP3gvLM0MQWujgfINTzBX9rayU4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6RtZJAV/IfKNb3ClVvv/vp0hi4b43qxFqexcBgRdyAKRMmcWpDMx7xQcOxRVpETQ+MNkU+SXgrcO+x78Iuvv4CP4KpEVQNewzSSog6BRtSUlWXg+Sguvhpq3ckfzOkbRXQkSnPqB+Mtx4FTKg8ohjDJFWdHAzPcIBR2a3DuD+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H0mPXM+f; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H0mPXM+f"
Message-ID: <4fac12e5-95d4-4a26-b861-dd8191386d64@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773345817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tD79ZTMBx9mYEc+sP3gvLM0MQWujgfINTzBX9rayU4Y=;
	b=H0mPXM+fKFR2bRCLpWmx6AN/ALFWKG7HCvmnVCtcUkbOL/MjjPvwky9N11wxlo80rfI/jf
	Ncib149unskn8lFw/Pv2Bl/gwU6vHT+XRZB7kRJb0hifK4rogMj/frymuWHxw/iXpyBEiD
	9hcsBDKMiERpAOiP7c96DyNaiSjR4Rw=
Date: Thu, 12 Mar 2026 13:03:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf, btf: switch CONFIG_CFI_CLANG to CONFIG_CFI
Content-Language: en-GB
To: Carlos Llamas <cmllamas@google.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org,
 Kees Cook <kees@kernel.org>, "open list:BPF [BTF]" <bpf@vger.kernel.org>
References: <20260312183818.2721750-1-cmllamas@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260312183818.2721750-1-cmllamas@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/12/26 11:38 AM, Carlos Llamas wrote:
> This was renamed in commit 23ef9d439769 ("kcfi: Rename CONFIG_CFI_CLANG
> to CONFIG_CFI") as it is now a compiler-agnostic option. Using the wrong
> name results in the code getting compiled out. Meaning the CFI failures
> for btf_dtor_kfunc_t would still trigger.
>
> Fixes: 99fde4d06261 ("bpf, btf: Enforce destructor kfunc type with CFI")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

