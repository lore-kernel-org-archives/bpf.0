Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81585366543
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 19:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771616715; cv=none; b=SmfEqePOhvHh6RQmVlsgdLeeADuOVKmTTGW6wJCH8GBpaKCE1Zzgi+34N6/wiXLhfPsgIWr+RaCIrs16PdMbvAFeIoVqJgK4wqRd1TGlmNuY7YMd2cHQjeqedTRQaUKXCHfTK/c6f35P73FlAQ/D2q84ZPTDhC2zq+FWSbUvBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771616715; c=relaxed/simple;
	bh=sQt4x6DVx0xpWhayNrs6P5SzbHUNvXWzMx5k0pyWits=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gY34Txa/gUxwPLF319WRv+qXbx4Z1X2hs/iCbMonTHuxCWjsDfuowC3WSw6P1LSznan9Prpy2OgOSg0LRfnRg0Zbw2wuvnw0gOdLzg0w92Mof/7opWPtKoTalqGtKBxq6x1n3aGKEQBe9A6YxuX4i4EMRNxynQYC1hErq+gsC2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIF3JyKf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIF3JyKf"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48375f1defeso17391305e9.0
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 11:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771616713; x=1772221513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3XZ/QuMduukP9A5hq9cabXx7Rr5IIjFPXZlt/zmuXMU=;
        b=NIF3JyKfTp/HDsGDIMb97HFb7NaHcJsbrNW1uipxpB2FfTbJG80H3SHSIhHVlv1GrE
         4x3Pe3IR8mxnEhIqAOfLsCxujTi2PPxiaaajxtDGJU4ts2fC34Z6NmEyCdDLyNN4cV5e
         zQXOcA/LVjnx0vmTtNMqL2CKK4QwiBaYOWNZQq/IjWlTBJX7X5cMd/VcnrNLf0Y8w8W5
         0lBgkMmm+sAw3OCT/GfoZYzdrd/WXOGhbUQEcr+c2o7g469G9nRSlZ5CWZNMXATjbhMV
         HeYIjC1J4ZBTrLQR+iBfOx41IllQHKWNVgInk5O2R+JHyfoCUKOpxdS+t5Ii0NzdcpIz
         gITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771616713; x=1772221513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XZ/QuMduukP9A5hq9cabXx7Rr5IIjFPXZlt/zmuXMU=;
        b=wS21hGCNH0nuWwm3wqTCVAe6+FsbatgMNxfqv1BppzHslHWmwwyQNEccW1Ne6pXGYv
         pF3tY2OKHmMB+vmKsOSczDmxhVd9aiz+egs3eHiPT1r90A03yBRwavFNBgJ/VmEaSeRo
         asEO4kLgfEg2U+VYwtA+89rZPcP/O2GF2f4rhiLMML2lG9WrooA+mpS2gNjbOYya+Ll+
         UoKL3d2NC2PC2AowESfv3aroT8iOIGbMt2Tr/kuc0wkT4WTWa3cli1AGKmRKukYWirJU
         IdFeqQI73eeQVlDaDGi97+ItEUB6/XgtDw7B4NFBMFSb7Iq7NqhmFKN//CUeTaOCdq9R
         iNkA==
X-Gm-Message-State: AOJu0Yypzxj639ka6YFMXu4c2nj1//wP8ihRDh6G4LfFu/QsLVNN+39p
	YiI4qLHrrb/M9JSS5CEAu1XUyIrwfHm+ZtZNbk+WbWSND0Bz7mQfmvBB
X-Gm-Gg: AZuq6aIDcgEAql0ue3bgi5DyQJksWwrXJx2Ei99XBFH+oQuGVBCNIJrijikbkceIhYl
	UPvxnDATO4RlfEHxN0tNjEXVbePC6Xs/trZ8+ndtOp3S4mH83FqKZWYf9avbeK/wGBDHUqRMJHj
	q+SQJDKhWM75ZJdIvyoGx/Ao/Z6h/YQl2/bL/yetn2M5S/t9kDked9BRgB4vCKZOAMl0bGFQc5k
	aj2PFnwIiauhM7kl2GIUztbYhMFtfEB4JX+SPBppB20GUoqbKYUThYlcXTEe9Gd3WP3iVI/FGtd
	gvORjN33smdIwQujBbbfoY4474aX3FbcPhpP0J+9ChsRH+dkTfOeyYDts//3zLGhlSehfiB8NQZ
	4vFfEpUFuVvMkCVIEfPeqvmkWcKbCJrdomRcq/jWEITcjMJs+2JzYmxRPzxDnnJH9uEjsbwlzFW
	04TfILEuTDrOT4b2g5sUnz2L6M2Zat7Ac2zXlVXWaTeHFEG8I+7JF/eH6Vodt8Jw==
X-Received: by 2002:a05:600c:8708:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-483a963d62amr8274825e9.32.1771616712633;
        Fri, 20 Feb 2026 11:45:12 -0800 (PST)
Received: from eagle.home.marco.cx ([2a02:908:176:3bde:4cd9:20ce:f6d:ced6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a4300c4dsm26665805e9.26.2026.02.20.11.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 11:45:12 -0800 (PST)
Date: Fri, 20 Feb 2026 20:45:11 +0100
From: Marco Schirrmeister <mschirrmeister@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: Re: [PATCH v2 bpf 0/4] Fix invariant violation for single-value tnums
Message-ID: <aZi4yYKlOgdsRu_W@eagle.home.marco.cx>
References: <cover.1771594636.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771594636.git.paul.chaignon@gmail.com>

On Fri, Feb 20, 2026 at 02:55:04PM +0100, Paul Chaignon wrote:
> We're hitting an invariant violation in Cilium that sometimes leads to
> BPF programs being rejected and Cilium failing to start [1]. As far as
> I know this is the first case of invariant violation found in a real
> program (i.e., not by a fuzzer). The following extract from verifier
> logs shows what's happening:
> 
>   verifier bug: REG INVARIANTS VIOLATION (false_reg1): range bounds violation u64=[0xe01, 0xe00] s64=[0xe01, 0xe00] u32=[0xe01, 0xe00] s32=[0xe01, 0xe00] var_off=(0xe00, 0x0)
> 

I have tested this patchset (v2) on an ARM64 system (NanoPi R76S / RK3588)
running Void Linux (glibc) with Kernel 6.18.13.

Before applying the patches, I was hitting the "REG INVARIANTS VIOLATION"
stack trace and BPF program rejections during Cilium 1.19.1 startup.

After applying this series, the Cilium agent starts successfully and
the previously rejected BPF programs now pass verification and are
successfully loaded. There are no further invariant violation warnings
in dmesg.

If there are any specific BPF tests or additional scenarios you would
like me to run, please let me know.

Tested-by: Marco Schirrmeister <mschirrmeister@gmail.com>

