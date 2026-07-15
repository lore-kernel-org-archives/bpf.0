Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4521F7575
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 00:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784075343; cv=none; b=BWNVGXqftilJ1b+UhF4X4OLI0Dtv4/4fSbLwhWeFzQeXO6SYGcGT3QxfwjR1ACNEfvgecNIsRmhMMqCNVq+MCFgcNU0OGrDHYjqITPNSnbX19tG3z51Wy7oo2AHAj8E6WmtJX98UCmsfXllVHPrHvx5Amk+aUqQVI9+7gwvc22c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784075343; c=relaxed/simple;
	bh=EOdouksHbU7HoTYLTd9sTytB4GWL1iNi3aAR44UL+oU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ixH8uhTlPs/E/ehzEkoGcNCqu/VJcibypyZ/ZrClGa2mDTt9DIEJe5kQXDBnQ+tJYGGaid4EdQcpJAk/GGq1xdZwMN0PXUZWTRskJnB3DeYESKpxGKfA77ju1TAtt2c14vRLwhrzU+U+e5L+8ZSV8l7qwnmmYu13GkzZXipUU8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oLVqAinW; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLVqAinW"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38759bcd877so4236016a91.2
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 17:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784075338; x=1784680138; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ajpIRi7O5d8LXEs8HVy9pi3Mo9jVPVsznVYgyaXs1BM=;
        b=oLVqAinW/+aH8+l+eReR6zKqFio/TpeaIVqSKX7qGDRdgT2itxtb0jHE27stVpfAHL
         +YLEmcLMJapCgqYhkbaijGju7/ydQzFwYAznMifmX7q1yOjt/AfO21KV1mo+lPhjQo8b
         qkDZBdf9MH9owX/d++6MgVqoXTMlf8WMgfFMJa84eYsjSKaRXukaK2h+bTm7L/i36jIz
         i7tz+OIiN0+G42Pv5oTDCNNTSCnCo20MNozj8Amd2SbR5vRQJCQLQ3vTlmxRFYPht8vI
         HpCDLMSWguE3DqolNlhxV1Kr4BUQnQIQRiTf5rOZV6hFVvNGo4HVwAw4XVYS67KVrv8C
         ZrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784075338; x=1784680138;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ajpIRi7O5d8LXEs8HVy9pi3Mo9jVPVsznVYgyaXs1BM=;
        b=c7Z203wjJ5+CrlkqhEMtIaFwBfN6t14OON8g4aFwGeeFPfSsDB5MjlfKSFjDHdTfAO
         amZRTLPlcRBptVLamixortP0xXpRKbNcjO/xtk+EiT27kubVoxWrGkq440FRDCiPvEK7
         Q83cDZ0fFo12NvQZ0Jbg93Ffj4Eq24jWAuGTI4qIlGl5xQCLCss/Br5Y+VD7Usocka/C
         8p2CCQfrGaYPYVTSTDLTRmjqqxYqW7sCPuFqA/VOsz4gDR+mYAlpBGHXOxSz/H0OmFau
         nHHZdLwXgt6StNAzpNAJhNBVbd8GjZKaMYVpl2O7MgmdPeUKucSyJX8ZWq8iCDQifIwe
         wyhQ==
X-Forwarded-Encrypted: i=1; AHgh+RqkE5P9+j0oSttg0psfDoQJK8WGLdpoxzp7+8sINx720gCUSBVpPQUNDESIbJRSyQlATwE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2KNU9RLcdFvkwOohUA/qb2CXG1wLhCrqZGFS8lbfqjz5xP4Bx
	SjhUkqPmIR9UhfcaEAv7Tyh8XC+F1AUL0+GO0ZMFUYmcBABOj6Cdh7jCPSVgl+qW
X-Gm-Gg: AfdE7cleiq+YyN4IzKa0CpFUKhi6DGczl31mqk99uYVlsQmOcnNTVE3GjI8tkFcb3TM
	fd/lvjFGapMa5vODYHCp+4tItNMCfi/VdHxJ8LSJ5Qa8pLpdyO2xxCktrU/o7GDLZs4B9WqAPC8
	FQNk6wxY6GXpIT//+t8WPQmDP7gablQVq2mO73XM3x2wKz3k9W+iNW/Y5KPG2odSIxynjYo4KFl
	MiVzQOeViLV0gIFF2QtDZr3TfaqTP6jpSj2scSnZP5CkfX+6wdyW8Y1fDtWtuUtFP9l1mebLLEO
	fyKmioMofROsiaRAyq2xBiqlyVg6T3uIVWyL/utoQdG/qfrpg9+piKNmrQ3GQamTnpBQmNZ+M4T
	eAiZtlCJ2Snyi7t/FT9ycYl3keet98XvrK3Kq6oOY+pv23QeLikcE3q0uEGHzuz3rEBH1/ghxlu
	0SxsIS8zEv3/vss76/
X-Received: by 2002:a17:90b:55cc:b0:381:22d6:f7a3 with SMTP id 98e67ed59e1d1-38e2a030362mr682173a91.18.1784075338228;
        Tue, 14 Jul 2026 17:28:58 -0700 (PDT)
Received: from [127.0.0.2] ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm86075098eec.18.2026.07.14.17.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 17:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 6/9] binfmt_misc: let bpf handlers pass an argument
 to the interpreter
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me
In-Reply-To: <20260714-work-bpf-binfmt_misc-v2-6-57b7529c002c@kernel.org>
References: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
 <20260714-work-bpf-binfmt_misc-v2-6-57b7529c002c@kernel.org>
Date: Tue, 14 Jul 2026 17:28:38 -0700
Message-Id: <178407531872.2243172.4159451666378990368.b4-review@b4>
X-Mailer: b4 0.15.2

On Tue, 14 Jul 2026 21:58:11 +0200, Christian Brauner <brauner@kernel.org> wrote:
> A bpf binfmt_misc handler selects an interpreter but, unlike binfmt_script,
> load_misc_binary() builds the argument vector as just [interpreter, binary,
> ...] with no slot for an argument to the interpreter. A handler that wants
> to reproduce a #! line therefore cannot express its single optional
> argument, e.g. a handler that resolves $ORIGIN in a script's #! path loses
> the argument that followed the interpreter.
> 
> [...]

Reviewed-by: Farid Zakaria <farid.m.zakaria@gmail.com>

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>
