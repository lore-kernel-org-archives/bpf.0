Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF41223323;
	Mon, 13 Apr 2026 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776045588; cv=none; b=juPtkjBL+Vv0e6GmpdadHln0fEgxdcZQdrFFUOi/00rZFhUzXQvZj1MjQeyU/2s7qQAF+9jUAMBms7B7r8ZY8CAtCQzUZKEydtpEFeAnlAoH1Qt0KHyrjBB0T5jGkHQjzJqqqeTDZGQxLCTa4kVBYsjuDByRODN60+n6F56I++A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776045588; c=relaxed/simple;
	bh=SW3kdgAMMk1CrOG6hIuDvqqTZdWtCKfcPxSWXpnIkiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M0/Lj9MBroeSuFCQ32Uu6u0YibLUR4FP3265L7RolqfvTX+SivhMu/qBuj0AG1TpQ5jAMB1B0L5TpQY6O8CXD8tHSvQ48Pvv/wbFoZcaAqsbzlUgt+UTeSSd0w+LqIMZQVy8NFVLOeLu7LcS51YjntOL9oasL2g5we4nbOyU0jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QbPagGFn; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QbPagGFn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=bF
	B9ezxilDEXzMXCA8jasVHzR2QUbxqA/UbWKTsBRLo=; b=QbPagGFnJUW0jzpq80
	Te2ytxESEsXdE9cFUIXeKjGkOipsRZ7xPkrEsv2OKyCMLLv9WLR5k7uikxRkNINj
	oV3MI2zUKId6tJ158IXS8abBAFXZpeX5qqEP/hPoGMZq23+2VMUhXRjkeWUd2qie
	eE7+4rHNBhjJtR380mMpgglcs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAHCXPMTdxpN6CoEw--.40560S2;
	Mon, 13 Apr 2026 09:58:37 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: menglong.dong@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	jiayuan.chen@linux.dev,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	leon.hwang@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	mattbobrowski@google.com,
	memxor@gmail.com,
	song@kernel.org,
	yangfeng59949@163.com,
	yangfeng@kylinos.cn,
	yonghong.song@linux.dev
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Fix Null-Pointer Dereference in kernel_clone() via BPF fmod_ret on security_task_alloc
Date: Mon, 13 Apr 2026 09:58:36 +0800
Message-Id: <20260413015836.73506-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4726660.LvFx2qVVIh@7950hx>
References: <4726660.LvFx2qVVIh@7950hx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHCXPMTdxpN6CoEw--.40560S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1rCw1DAF1DGryxKry8Xwb_yoWfCFX_CF
	W0kr17Jw1j9wn5WFn8CrnrCrZrtwn8Ww4rZrWvqa129asxKayUAr18Xrs5Xry7Xw1xXFs7
	Crn0gayxCw1fZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUmLvPUUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8g0YkGncTc0cMwAA3t

On Sun, 12 Apr 2026 11:39:53 +0800, Menglong Dong wrote:
> >  static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_range *range)
> >  {
> > @@ -18416,8 +18522,13 @@ static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_
> >  			*range = retval_range(0, 0);
> >  			break;
> >  		case BPF_TRACE_RAW_TP:
> > -		case BPF_MODIFY_RETURN:
> >  			return false;
> > +		case BPF_MODIFY_RETURN:
> > +			if (!bpf_security_get_retval_range(env->prog, range))
> > +				break;
> > +			if (modify_return_get_retval_range(env->prog, range))
> > +				return false;
> > +			break;
> 
> return false by default, as what we did in the previous logic?
> 
> +		case BPF_MODIFY_RETURN:
> +			if (!bpf_security_get_retval_range(env->prog, range))
> +				break;
> +			if (!modify_return_get_retval_range(env->prog, range))
> +				break;
> +			return false;
> 

Okay, thank you very much.

> >  		case BPF_TRACE_ITER:

