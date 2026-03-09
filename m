Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41EC284881;
	Mon,  9 Mar 2026 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075678; cv=none; b=ERDNfuqp2G34Dfvl29x5xct0rAotjxBFQ+R1TNn8mg12utPCfYnhDHy2QXw/wlmDi8Wa9q9TuY0kYI4cKgKGWAkPgem0pA4E3VVjBBYaUV1OPz0AaRRXd5ss2Pve/4DpVT0MFSxiC8rdAUZg3ndkBqmLUrYMLLRu66nTmnpqgqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075678; c=relaxed/simple;
	bh=YjfGGBfXleHUjEIZU6C03gqMFHibd02UrGq5LGn5zUc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=QS2hsmUMudK1KhgIX9JjunHYfJ7evIocK1R3QRIbM20xnZQM7cxU4pC68InrgkDwa20ttqIBeAB4P84xlPhgrNuWf2AJE5scx8IbpZPXmY3K3yJay9IUgIJpBK+frJ5aolio6JKnj6OkXCjMcAxdWBL2hFfV7diAWRbn63W1nQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=TZl/XoVe; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="TZl/XoVe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=UMbXCxutRDxcD2UmZTvZwlLDyIxErYFQZ+refN40rlo=;
	b=TZl/XoVencF8ELmdauqrELkepbwJSsHy0EcUdK7fpQ7JEXJa3laxdHdtRV4t2G
	h5JDAui2gO8ULA6k9kkbYHR04W5qEv75wfMEENypQh3f0rHoTBBZHgKlodlq/On+
	UIDrcAl3MFwhIzJcpzBivUuJJEq7CLfw3oZzbrVFxZu54=
Received: from ehlo.thunderbird.net (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3_wFT_K5pPVwIAA--.18239S2;
	Tue, 10 Mar 2026 00:58:59 +0800 (CST)
Date: Tue, 10 Mar 2026 00:58:57 +0800
From: Zhao mengmeng <zhaomzhao@126.com>
To: Tejun Heo <tj@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>
CC: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 llvm@lists.linux.dev, zhaomengmeng@kylinos.cn
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_2/2=5D_tools/sched=5Fext=3A_scx=5Fsdt?=
 =?US-ASCII?Q?=3A_Fix_BPF_verifier_rejection_on_older_LLVMs?=
User-Agent: Thunderbird for Android
In-Reply-To: <aa75CBAMNtK-L-ew@slm.duckdns.org>
References: <20260309022847.106150-1-zhaomzhao@126.com> <20260309022847.106150-3-zhaomzhao@126.com> <DGYECIPVC266.25320R7256YJT@etsalapatis.com> <aa75CBAMNtK-L-ew@slm.duckdns.org>
Message-ID: <E01CE742-1B6E-4615-89F8-8C6C360EAB02@126.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:_____wD3_wFT_K5pPVwIAA--.18239S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr4UZr47AF1fuFWUuryrtFb_yoWDJFg_ua
	yUKa95Ca98Wr4xJFn8GFs0vrW3GFWUJr4kJrZ7Ja4fG34kAFW3t3sYkr97Xw1agr4SqF13
	ZwsxZrWkXFyUujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRR1CJJUUUUU==
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqxNZ0Gmu-FP8NQAA3Q

On March 10, 2026 12:44:56 AM GMT+08:00, Tejun Heo <tj@kernel=2Eorg> wrote:
>On Mon, Mar 09, 2026 at 12:36:40PM -0400, Emil Tsalapatis wrote:
>> On the other hand, maybe the extra compatibility is worth re-adding=20
>> cast_kern/cast_user to the code=2E I am slightly in favor of keeping it
>> as-is to avoid churn, but can easily see why we'd go the other way=2E
>>=20
>> @htejun WDYT?
>
>Let's leave it as-is=2E The main purpose is to serve as an example for fu=
ture
>arena users=2E The benefit of keeping it simple trumps over supporting ol=
der
>compilers=2E
>
>thanks=2E
>

That's reasonable=2E I was hesitated to send this patch because it actuall=
y is a compiler problem, but I also has seen cast_kern/cast_user macros alr=
eady defined to address the compatible problem=2E Shall we use __BPF_FEATUR=
E_ADDR_SPACE_CAST to guard the code or check the llvm version before compil=
ing these arena based schedules, or add some information on README? After a=
ll, it  only demands llvm >=3D16 in README=2Emd=20

