Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD133E5581
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 21:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334906; cv=none; b=unXhweu5UMj3N2rsPb16JlYdzsXdAaLZpVpgDDRl7tms5LjcqW72LJdFVOEeq5f60IWooAp3gHrhXLnaY2DahvbeFlx+c9dWoULsCjkMkVEfnGfwxS+ddW1KhYaqnsDtq2MQxUu6t0Wh1AEPAxWhI/fh5iOjsq0K+OMtDBI8BEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334906; c=relaxed/simple;
	bh=K871zHWN3n0C2zDB1bqlvp9fRAIdcYLBTS4ZMNQLOgQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HnG/HQPpQ0aVm6kcYu+YGWoHaKmJQJwMSf5LoH9NWznLFxZ7+wU52nWAcd7vTz5Z+9rgck+1nKjKMdpeQV2PQwvcAiCGoggI5peQ65N7zMZdl71wpBruXA0X6I0BD/yNZ/rnQr0oTxNQPHJrJywykB0n+bpKpaEmI87AbpjUQN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nr5YWykK; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nr5YWykK"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e93e0a3364so1122923a34.3
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 14:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782334903; x=1782939703; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K871zHWN3n0C2zDB1bqlvp9fRAIdcYLBTS4ZMNQLOgQ=;
        b=Nr5YWykKeoQHKl9e/R9OYTX6mmiAk48e2YEZfFn0Loeu1Tl2dKA/94MWHEGdFpxVaz
         w6Se6vM+SbQH9W173RiTkGpGw5tsfU7dKh85NEUq5Bci1Ny1IDuEd2hIU0UHUd3+OMMS
         4zyH58kKgKBGo0aDqeNLimXJt1OX5qpJ0eT3I5pe+uiCrJ94SU15QOU+wYzaLguDw/Ar
         Zr++gnKo0BntU737aKpFWHrzezP90BjqnWpAODWBLBFoPBuwb+CcRJFuOKIWduxnUyvq
         7NdEKi+vDC98iYj+IeNtdQi+uGEtW6m/12+r5IUHcmjU2NBTU6cLXG/HXOhHI1Lt15gm
         dgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782334903; x=1782939703;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K871zHWN3n0C2zDB1bqlvp9fRAIdcYLBTS4ZMNQLOgQ=;
        b=a76qZAHueNoEtS8sg01T4gQIJWXWZvs6ImajjeijVmLRnvLq9EetWAu5YCKmSgShOb
         M0Fxo1+oYdkBaTazjLROAlmHTIyADoxIp24x41H/HNHMboyymO4VkXDemqrELM2hKTWQ
         Jkr+Xgu6zoyaykLmnugfgXxVfXPCjP4eFE+SDSjFh3/fQacCed0vjrLfbhCKSjmGmAtH
         kYsG+nO63mrdC5zj4pKf74i4pEwtlEv+twq+HCgytpbxwkn8qSTf4ax4fV5BdpIJV8tV
         yBYgb4JoYmDWMjOqAWg9Bq4E6Wp7TZCwIAS5dpMEOSq4AnLHw7ereNb9NuUaywvC2SEN
         yoiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/P6D4QmJNYCsiBlU5Ngh4IhdT4HTDH/xjcUs99sUeFCUee+CG3SWVG7rDq19uJj/o+0QM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcrnxNpffQ5Bk33rVef4YlbIoA9pAtEpdcRfj0ovzd/6NY5fOF
	OMuB9UJA7cJzznXaiw3HYSaq3y8D/tCCNtQ5373ADfSmXit/lvOXrNdc
X-Gm-Gg: AfdE7cn0K8tCkfe+qa2nSxNw0OXuwhWJtVMsCYhx+ek3bFSg4xXf3c01p/gPNaj0UZ0
	F0lvqetUvJ1oXtG1CzcqvxlKNvCMcAAZnrgxHVLQDxmJbnrUwn3a8J29ThnRQQ0LrQoWQZRBTfJ
	nGDiGTjEcYt1rT16G2yLCkjtwHMEldvJy7pvaB5rj99BGyLQFPtynqdKpQSCHGiXULRMED5PUv5
	OPmMUrUimsrtYcH371hkcxgpTRIL7/m3My4kcfiUngBQbQD3h71EpfryUfPsXKaXa0o/X4gBlq0
	3ceXGkD3RPOUv1/cjscbpyvcpmY7MU67SYrbaDLYaZF2ZQY59WEwYJ+7749vtSaR6En6qVBukfn
	H7PJgaPksZ+mRaSbVMcng3jxvnyYJ+o6twdwzbsnI5TwaWmJ1FZuMZB18CK2MjL0Bt6V2BcScto
	9ZKHz2/DwqC+Cx+ei7wc5o60Dy5gTs+7SLd6CGupG79iVw/bhWwVdRi3/iIy1j6VviIR1SP7gjb
	snPsg5RpBnEkFTLkQ==
X-Received: by 2002:a05:6830:3788:b0:7dc:c338:d23d with SMTP id 46e09a7af769-7e986c0ac84mr4102229a34.14.1782334903024;
        Wed, 24 Jun 2026 14:01:43 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:50::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e94429fea7sm11967035a34.24.2026.06.24.14.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 14:01:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 14:01:41 -0700
Message-Id: <DJHKZQ8DHCW5.QCBIXNEWDLEC@gmail.com>
Cc: <yonghong.song@linux.dev>, <jolsa@kernel.org>, <bpf@vger.kernel.org>,
 <tanglongjun@kylinos.cn>
Subject: Re: [PATCH bpf-next v2 0/5] bpf: add bpf_memcmp and bpf_strpbrk
 kfuncs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Longjun Tang" <lange_tang@163.com>, <ast@kernel.org>,
 <andrii@kernel.org>
X-Mailer: aerc
References: <20260624093638.117062-1-lange_tang@163.com>
In-Reply-To: <20260624093638.117062-1-lange_tang@163.com>

On Wed Jun 24, 2026 at 2:36 AM PDT, Longjun Tang wrote:
> From: Longjun Tang <tanglongjun@kylinos.cn>
>
> This series adds two new BPF kfuncs to kernel/bpf/helpers.c.
>
> =3D=3D=3D bpf_memcmp() =3D=3D=3D
>
> BPF programs frequently need to compare raw binary buffers, such as:
> - MAC addresses (6 bytes) in XDP/TC for L2 filtering and forwarding;
> - UUIDs (16 bytes) and hash digests for allowlist/denylist policies;
>
> Currently there is no safe way to do this =E2=80=94 bpf_strncmp (helper) =
stops
> at null bytes which corrupts binary data, and hand-rolled loops are
> fragile with the verifier (as evidenced by the local_memcmp() workaround
> in selftests/bpf/progs/dynptr_success.c). __builtin_memcmp may work in
> some cases but is not verifier-safe for arbitrary kernel memory.

Hand rolled loops were fragile in the past, but not any more.
With bpf_for() and may_goto/can_loop the loops can be large.
For MAC and UUIDs even old verifiers can deal just with with "bounded loop"=
.

Sorry, but I don't see a human driven motivation in this patch.
Looks like AI flagged something and AI sloped a patch in response.

pw-bot: cr

