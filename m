Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD1B1C862D
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 03:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786072155; cv=none; b=LiTnDi8sQQwKA5jGK81gwd73AIx2zAoPK3kZtKMLAO04ITPtTxjF2rCM21+h7c5AKM0JzdVuLv6lCrqd3LkJ/QMcsm7MU/z3PShUDAzsEp5Dy6QBXY88hqlFaQ1TEKK1jtxcrEQR52dlPulone0qGWaXatHWcmFWN9L2tPNt7PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786072155; c=relaxed/simple;
	bh=qJsIrlpjxAoV0i3edp0eZ1i+xWJNB6ppxSNKd05uYVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmnUaOECu95/XZfi1G+IfGACESSDz4B104u49sea65ZWbqAZ4mAe7CvhQ/l9yvPWx+esXwpajjHNJ1mBHSuxAT21bgimi/bip1X29lOjiTEFCSRNsUODeMOX889kUNvjoL130Ix1qe7eyKLDD6prIMJhKPbjcqaunG2oUdKRAN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wO6ZTmmc; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wO6ZTmmc"
Message-ID: <6a86c972-99af-4e35-9392-8776d57dbc9a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786072149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+V+3Rilgi/Wp7c2pZmJ7w3fau0rAoMuzLvq1wpuXAP0=;
	b=wO6ZTmmcXRH4Dr8L+cO6BsDaOEQelv1Uj4S+IQbOowagCg+iJsGmPTf5N03wgBn/4hi5xn
	JIjiQj4I0CIP3xCeCHJXCdQHx7E9FyCB266L0Ou3QK9270rye0xj+0rxByBbJoUOYRjTOA
	QqXrJnifUNzn7VXjeEoFaViLgkapohs=
Date: Fri, 7 Aug 2026 11:08:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/5] bpf: Add ksock kfuncs
To: Mahe Tardy <mahe.tardy@gmail.com>, bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org,
 liamwisehart@meta.com, martin.lau@linux.dev, pabeni@redhat.com,
 song@kernel.org, netdev@vger.kernel.org, sdf.kernel@gmail.com,
 ameryhung@gmail.com, kuniyu@google.com, memxor@gmail.com
References: <20260806182234.380833-1-mahe.tardy@gmail.com>
 <20260806182234.380833-3-mahe.tardy@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260806182234.380833-3-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/7/26 2:22 AM, Mahe Tardy wrote:


[...]

> +	return ret;
> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(ksock_init_kfunc_btf_ids)
> +BTF_ID_FLAGS(func, bpf_ksock_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_ksock_connect, KF_SLEEPABLE)
> +BTF_KFUNCS_END(ksock_init_kfunc_btf_ids)
> +
> +static const struct btf_kfunc_id_set ksock_init_kfunc_set = {
> +	.owner = THIS_MODULE,
> +	.set = &ksock_init_kfunc_btf_ids,
> +};
> +
> +BTF_KFUNCS_START(ksock_kfunc_btf_ids)
> +BTF_ID_FLAGS(func, bpf_ksock_release, KF_RELEASE)
> +BTF_ID_FLAGS(func, bpf_ksock_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_ksock_send, KF_SLEEPABLE)
> +BTF_KFUNCS_END(ksock_kfunc_btf_ids)
> +
> +BTF_ID_LIST_SINGLE(bpf_lsm_socket_sendmsg_id, func, bpf_lsm_socket_sendmsg)
> +


I guess bpf_lsm_socket_sendmsg will not be compiled when CONFIG_BPF_LSM 
is disabled

