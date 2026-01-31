Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A69E2F6900;
	Sat, 31 Jan 2026 01:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769823668; cv=none; b=QDJE4YQLlpzZzeAkNv9oQai7eNnlgjewf4WHNviYRittfddvPJBy2TPoqOg7q/UBGEnOk8WoHhM9WhXqszqyWDKElY6arkyuMNj0FTB8FLhIJcvziKuuBT2AsG7gZlOVq6Qhb+an8IuCfkdg9iulV5xgRmmgX44dmoeGwbfsZNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769823668; c=relaxed/simple;
	bh=9g/Pa5RNE191bkSQQP3+3Whya8egg4mOBVQkzHmmqC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ix6pbFiNIVkUbjVIgTfQuCCCsprakIhvANuJH19Vtewt+OW52kS/gbdkDeTgOb0opmmAndJlctK1EaGRElILB4Tbw8MHsNnW6uyvtpmY+De4imMZDFic4GRQ+K2LFGXb4mVyVNaOKre5EUrL4T3Ng4k2A9vvHgJl43usF5VYUMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=RQgIXoR1; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RQgIXoR1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=k/nanrfO06Zf2pEnessLIfhLo6WXfbSNsWwMBTomKcY=; b=RQgIXoR1RuGmkGc6Ewp0Czjr4i
	J/kUBp8KlDxXvuBHPObA/lqe0hjXDjpcN+xkGs6ZFDkWGuiiCKW9AZTHfSjKxHgkgJbJ5/Tb9EN4M
	uai/pZczwgh3tafu4uMCHloZ/Wv056DAHbepeAfuZ4wh8P9j4+uGkruEa3WvK8VrVycEBVjP9PFvg
	vTCwVJ0ICc5/qnvxQ8Z4GBIHO9L5g4Ny02bg0QgUyfczT3ALF9LIrX/8cZKl4FSYllQCe991EpTn5
	QPrNM+I+QCVKLMf2ax+IFrXKabX0XSLFU1+FiXGaK7SoJf+vtMWGKiCs5ImqwEycFifJ3eL4h8gq9
	H/oEIeuA==;
Received: from [58.29.143.236] (helo=[192.168.1.2])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vlzyY-00By61-EJ; Sat, 31 Jan 2026 02:40:38 +0100
Message-ID: <be3ac5d5-55c9-40e2-af5c-75fd716dbea7@igalia.com>
Date: Sat, 31 Jan 2026 10:40:27 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/bpf: Make x86 preempt_count access
 compatible across v6.14+
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 kernel-dev@igalia.com, bpf <bpf@vger.kernel.org>, sched-ext@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20260130021843.154885-1-changwoo@igalia.com>
 <CAADnVQJKguqUD0bYh=tHnrGXOUOMrSk9_72HDFVcuMsv7=S_nQ@mail.gmail.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko, en-HK
In-Reply-To: <CAADnVQJKguqUD0bYh=tHnrGXOUOMrSk9_72HDFVcuMsv7=S_nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alexei,

On 1/31/26 5:23 AM, Alexei Starovoitov wrote:
> On Thu, Jan 29, 2026 at 6:19 PM Changwoo Min <changwoo@igalia.com> wrote:

> 
> Please use proper kernel comment style in the future.
> We don't use old networking style in bpf anymore.
> I fixed it up while applying.
> 
> Also use [PATCH bpf-next] in the subject to help CI identify the tree.

Noted. Thanks a lot!

Regards,
Changwoo Min

