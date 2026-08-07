Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8667E3D668F
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097476; cv=none; b=L/7mhGdFA5CWMKt16bzQwVcID7xgkDqflwqsJ4v/3RDgy9k6+rj8JxDwVKUj3p7q9fgd+S1QY7We7tYtuko39lLr3+OYUe/c1Xm7allLRzggOWuF7OnIOwU3x76JyLi0B/7BacPMs1QwDlkcWUJr5BNXyo7cVXFgK2eLdGHPmqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097476; c=relaxed/simple;
	bh=PzJAzmMlMAwzz07m1rStOfmSbMehiPpj8jWRb5DmwqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nq6qPtvr7PuEDMLwIM+d0cNW/nAbaHCBsXGQrv2Sf2O1O/0La6fuBiCpUdwbzvsYxgNpMUAKa4f2A0E26Jc10qH5QwLJ/JcSzcrlcawWHOG2gIrmzfdF9fqy0UHctcILai9uXnL640+h9rVaQG36ba0navZoO1hKFHae04Upm9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UD83MMOz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UD83MMOz"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso14192705e9.0
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 03:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786097469; x=1786702269; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sfkgU7jZpdRNXbaepKxMlnZZSP7VZ5dxP7EkmOF/3y0=;
        b=UD83MMOzcyTD7X+V2QlIB9xnMgUmONeRCkdDp41xPEqcQzNmtxI8xqhNprxKHtz5Bv
         kSVTLrG/F7cLh17LbFg7D9lydmiv9MrpZaqX0IMuYJpQBGDUB+Ka2e/FO2k6S/r6vAHv
         k4bGnuHiRe8AvnJ/ag/qycJz9QCAcdRVntLlOrp+5pc396NKxaePv8eYy9GtJ7sgMoQ8
         f2faXryON032p9UraTthfJNrhCmzGmFr6snT9DbEdGI8E/JegqnmXJOLPULWKCt3MnZI
         HKhrNNe8a5PGX4toEkcMofvmZHSmq6IFPTwMr0iMMddUD8EyZhQa/qxyPK9PEhMdR77e
         kQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786097469; x=1786702269;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sfkgU7jZpdRNXbaepKxMlnZZSP7VZ5dxP7EkmOF/3y0=;
        b=ECGS6ZsWPCcfGmIEJGSSRSqi4SRyEx/vhdPhuaJfIkD1TESa5htgkLhPNEY5HKmhW9
         WJAZ5jhUtwWqJclXmoaH/VG05d2BbdH8YkLeDeVLIbmoZI6z0N5uAHJ6OzxzwcWzb6Ms
         3f8KVHyE3ys+87uCiQn9tqJ1MgIU+TLnkZttyHSiNW89bn3ceb8Zlekt+jtVk45W2n2V
         5JtrAEekOfr1GPgC4VcvOypEIBqT/FlW4Z6A/kMXjEdSLLDc6QqfprKL1SyFxcSjfgcd
         UtQLkCnGUGrlGNIjefuyPC9G49atPkPzl5Xa5LxNrpR0NdOdtoVvHncCKftgP1JqYXds
         jrlA==
X-Gm-Message-State: AOJu0YxZHoeZ4dJzv5sKqaODGWK0gSysWdEqDWCg+a0B0rihsWR+pymj
	S95KUxK6lMKSoG73DkLut+aSTsBBNIJM0nGTZiLShuA1KR2YiTZRksKr
X-Gm-Gg: AR+sD10hm4NmGzuZu4v7NLENuquMrthVALyNT8GXVWuYQTMxXax/XS0UfydSB5iebbf
	AaVLFIJ72+tUD7m/inJxjrdyIn2Mjy4F6VG8HaTp0DwQ1c8Rd5tExWc9mmbAaTMt7X0OQjDe9eJ
	EiBTFVhOi86bmdhyWIrQgJY5hWqQV90RzBEL/kTsIq7YICnXFqe5ZgoH+G6CJFx9NQ89SXqY1Kc
	N/5xOXJkVQNIKavPSlQ2ySfkGJHdtpBFFYTBHoGKaGYyeEDL7q0SJylLl2vA4gDumytwnXFGawu
	eFlMoLZjfWPlotJhXkmdJkOxKo1kw8SRZU/lkaBRi1D/vRoO2ZQMAFOELGtGPG+f5n2HwawQQB6
	mrzekiVCKYba35Wn47u0L0JNxNa176QYuhG8RiXw2w4lwv60vAuI4dwnoUKs2jUZVsPrqne1ZiL
	NCyFKSX0d+5GOx9CzoLl1Iu6z5Sn+vKcaTkOBO+w/uKn42UrrWIQ+Ds8us/YbaBAU4pCuBMIVts
	nUMZ+H88kVEmcyNMURgkuz0DHFW91SX
X-Received: by 2002:a05:600c:1546:b0:495:3bc6:d381 with SMTP id 5b1f17b1804b1-499553bcbc8mr121186275e9.2.1786097469384;
        Fri, 07 Aug 2026 03:11:09 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995919df87sm90789365e9.6.2026.08.07.03.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 03:11:08 -0700 (PDT)
Date: Fri, 7 Aug 2026 12:11:07 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org,
	sdf.kernel@gmail.com, ameryhung@gmail.com, kuniyu@google.com,
	memxor@gmail.com
Subject: Re: [PATCH bpf-next v4 3/5] selftests/bpf: Add ksock kfunc test
Message-ID: <anWvO7ZQh1eEHZie@gmail.com>
References: <20260806182234.380833-1-mahe.tardy@gmail.com>
 <20260806182234.380833-4-mahe.tardy@gmail.com>
 <c51bef73-17b0-430d-b473-7744141d6dab@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c51bef73-17b0-430d-b473-7744141d6dab@linux.dev>

On Fri, Aug 07, 2026 at 05:12:21PM +0800, Jiayuan Chen wrote:
> 
> On 8/7/26 2:22 AM, Mahe Tardy wrote:
> > Add
> [...]
> > +
> > +SEC("lsm.s/socket_bind")
> > +int BPF_PROG(ksock_socket_bind, struct socket *sock, struct sockaddr *address,
> > +	     int addrlen, int ret)
> > +{
> > +	struct __ksock_ctx_value *v;
> > +	struct bpf_ksock *ks, *tmp;
> > +	u32 pid = bpf_get_current_pid_tgid() >> 32;
> > +
> > +	if (ret || pid != target_pid)
> > +		return ret;
> > +
> > +	v = ksock_ctx_value_lookup();
> > +	if (!v) {
> > +		send_ret = -ENOENT;
> > +		return ret;
> > +	}
> > +
> > +	ks = NULL;
> > +	bpf_rcu_read_lock();
> > +	tmp = v->ctx;
> > +	if (tmp)
> > +		ks = bpf_ksock_acquire(tmp);
> > +	bpf_rcu_read_unlock();
> > +
> > +	if (!ks) {
> > +		send_ret = -ENOENT;
> > +		return ret;
> > +	}
> > +
> 
> 
> Since bpf_ksock_send() is sleepable, every consumer of the kptr is
> necessarily a sleepable program and thus has to open-code the same
> bpf_rcu_read_lock()/acquire/unlock sequence before each send.
> 
> Given ksock_common.h already wraps the insert side, how about also
> providing the get side, e.g.:
> 
> static inline struct bpf_ksock *ksock_ctx_get(void)
> {
>     struct __ksock_ctx_value *v = ksock_ctx_value_lookup();
>     struct bpf_ksock *ks = NULL, *tmp;
> 
>     if (!v)
>             return NULL;
>     bpf_rcu_read_lock();
>     tmp = v->ctx;
>     if (tmp)
>             ks = bpf_ksock_acquire(tmp);
>     bpf_rcu_read_unlock();
>     return ks;
> }
> 
> These selftests will be the reference everyone copies from, so
> encapsulating the RCU dance here also documents the correct usage.
> 

Yeah good idea, I'll just keep a slightly difference dance using
bpf_kptr_xchg() in the ksock_lsm_verifier.c program because I want the
verifier to bump against bpf_ksock_send() restriction explicitely and
not bpf_ksock_acquire().

