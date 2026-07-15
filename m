Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D910C221DAE
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 00:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784075340; cv=none; b=jIrYANnKMaY9QrhncsaZabQDRdoS9exAS0TqNO23N5yuIXfBQAN1fgCA232Ib7Su+Nos3npS6uf+vqHXHMggzc76aTjLjVlDtpXDtIBKjAe1KVBG3lS5J8vgoxwDzCBqmwz5N48eqnwGef7Dv7iZirGbSNKyWvC4fmg2An6v0qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784075340; c=relaxed/simple;
	bh=rDAS3gxFQkGx84z+5mChKIPQOCXxsvU+LYFSE3N3/PA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=REEeJqvaZkaWl7a0uUf7W6dE6UUCy5mgfG9f4mvEUSKm3C2uJxmjV/hEyZfpzif0TJ43CQn3DZ7ezG2YcjqBs46y7BcCmHnNF61qAwkCUVQf66Ud9fnnSVOTlv0TrNsO24RPXZzmb9QEOM7cKi6CeKFceM6rdX+WbJ/5eKYETrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1C3tWLh; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1C3tWLh"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-384c94c9414so1321238a91.3
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 17:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784075335; x=1784680135; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ftTY6hTUShaj3iSHGB+R65zugY4amQnONmDFuo3xbcE=;
        b=I1C3tWLhXutzQC0BmUK0Pg8M7ubIMdoB+8ODwNqx4Q6ZWBNwaU8rZHOnaVrBlx+L5C
         Cj4FcqVSogYRuYYG+KUKyIB7FHvmhHBUEM4t9YUNjOyYY9x9Mkb7g0b9JtenR+s0pzFZ
         f46i9YpmnYLhqmR1N/4Du6F/elimHcFquGaTbF5E78trM/mq+ql7vM6Wa0ocL8NvjAPg
         Tox2uXo6h8U1pIB5bVEuLIXrA2GCj/bap4ile99ffZwG3eEA+e7rW8h8tt8+5UuFWOLv
         PenikzUccV+XdcJkPnW0FxuhN9+gFqFecG2wg7u2fYi423wECjW8qLekVplHvt25xxxp
         4tOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784075335; x=1784680135;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ftTY6hTUShaj3iSHGB+R65zugY4amQnONmDFuo3xbcE=;
        b=mR2Hodju9s0DnlV+I6LUktlTpb17Rv1Cmoam+6m8f39UupTIC8XAkdTqfS3DdLTX0y
         4MTaCX1NigK51b+vQlF85TR/ilh6I55iIPj06g6dGLSSBq5nvBIh/95hXDpZPbBQjObH
         k5srb4q0704bw0HczBM9nJ7VgAAH5JMRFhu7HPNZ219amHdgphx+nX3XjdkFctCAzJ4S
         g6AQO0h6M5wpgtcQu38zI35ukvL6liae+cQy19UrWHpNcImxoKV8LtSvgTxIf9VaEq65
         J+jkZlhANhGqNzLitwBDk+T766O6Ctn31E5EoemHpT2kQrCLRuYIHAR154JUzMEJ3M1n
         6W6w==
X-Forwarded-Encrypted: i=1; AHgh+RqKCHHBdkTZWfs6o4RZb7dEY95/GiTroPvFvs1Oz/cWDQEn1p/nKHeKNrUaySrrugh9PbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+3HY4DfmlNhGiWS4G09M9iwIvby5/H6Mbgrrpwxpmw5p7ciBh
	toTebtM60+Vj5oWrMa2gn78OuPC4fpczdKgqlKQowVTCjwYlxQpe3aTy
X-Gm-Gg: AfdE7cm0AwcPqv9IMH3S1MpfXgdZKu8drVS6LTFUs6nFejBLmR/0IPRbNC9j1tVw/SY
	Yaz0XspmVrTD4uRjR0dFGQkZCYBNIEo59p9ND2ncgr6+gdSyIYeAfPKbVaB95C7GsMBhsViPO+E
	PAxAi2p+Whf0yxqxV2tlkx1s7GZM2DKFwg3l/g/gao6UOwbyOWjNK18LWWM/mxiyMTf68DOjtOh
	L2ALj1qorrBhZhJSkxJxuhtMR36aFL7apcqk/SwHBvCC7ymoK2EzlFqsnTRjUxso213hh+Sz6a0
	KnnlFCYse7H/kwhSyQoJj4T6Pg06qGkVhrC0WyP9+SSjsHEXbn5N/bv1ul+mx4uk7j1P5SMILh+
	0JnKWx+hKGxQYyvXfa1HLQIEU8UehnwblY67J2B53JNN2q2AjEL44HCbsFoDtVE4+CuhMnPEUZW
	W9e8zpbEFQipwx1WhB
X-Received: by 2002:a17:90b:560f:b0:389:8f6c:4d59 with SMTP id 98e67ed59e1d1-38dc7779d1bmr15305942a91.24.1784075335188;
        Tue, 14 Jul 2026 17:28:55 -0700 (PDT)
Received: from [127.0.0.2] ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm86075098eec.18.2026.07.14.17.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 17:28:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/9] exec: stash bpf-selected interpreter state in
 struct linux_binprm
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me
In-Reply-To: <20260714-work-bpf-binfmt_misc-v2-1-57b7529c002c@kernel.org>
References: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
 <20260714-work-bpf-binfmt_misc-v2-1-57b7529c002c@kernel.org>
Date: Tue, 14 Jul 2026 17:28:38 -0700
Message-Id: <178407531870.2243172.45650472171661452.b4-review@b4>
X-Mailer: b4 0.15.2

On Tue, 14 Jul 2026 21:58:06 +0200, Christian Brauner <brauner@kernel.org> wrote:
> The upcoming bpf-backed binfmt_misc handlers decide how a binary is run
> programmatically at exec time: the interpreter itself, an optional
> single argument to pass to it, and the invocation flags that a static
> binfmt_misc entry fixes at registration time. The selection runs before
> load_misc_binary() has copied the binary path from bprm->interp into
> the argument vector, so the selecting program cannot go through
> bprm_change_interp() directly without clobbering argv[1].
> 
> [...]

Reviewed-by: Farid Zakaria <farid.m.zakaria@gmail.com>

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>
