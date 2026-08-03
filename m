Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC29C21257E
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 00:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785716579; cv=none; b=t3VZQX7LSD3hvzjX6OV7erSCoF2HCiJMOgrfUpkAr44amD4Cjx5QEfrZzodqdOa0ABRreNRzfgQaXqnvL+MyOJwgV8nC3grATYQRjj+Q4JVYDHpebAzRrLNIxVYUIuBgcc3Oh4Zd6PmXEkZsiq39XpncBD4WDsZMmKDk0K0pyfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785716579; c=relaxed/simple;
	bh=4M5yW+HhZzRqydRSX+G4hKq8dIP70/ysR/uxwoTiR34=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ddxQ1m8yKD9laKD7d2xl9Jt5Ww3xijuNhGtia67VuzPJ/7lpSpVve1yUaNgJUhGXiDsI5x10MGMAx8y2iA//5r4XDuAWUF43tcBz+LPi2JioIww4X8R2ckFVWMcJZ1tG5DtXdNTWknKPBUOtIFreMPaJODTw3gDXaxRRt88PItQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTLnCB/W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTLnCB/W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA871F000E9;
	Mon,  3 Aug 2026 00:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785716578;
	bh=Me8hY1ctARZbJliSbYlUJdoCzqy3ESC9bfVyWOW4r00=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=ZTLnCB/WAvl6gL9dcQfVPsD2fOq6vcITXjBbwqkSXHqWPz5CdZbSGmmUcIv7EUkG3
	 fau2HYJcBWpZ9SVJMqGZZm3DfbHQupjWGS0q4gvc9ho0uZDL01qhYCLYmAEBt91H2r
	 W1sHZGOtqj9C6Rti4zRrpmC6nMeYPlL+otaG8jfSDipa0YUHG8p/ctGsxfvdaNyXjV
	 0qa5ML3Ib7FOypgptwhd2qN6iuNtSEAfLo7NIQLMhvnjzDTk28uvXAFxZlXOlkm75b
	 e+d2pVVWFu9OoXcWQgk9SIl84GPmWw3PVPdv7PHdrbFide6hOWJcLBnHQ9sXYsVr3u
	 waoFeMqS9moCQ==
Message-ID: <2be0a1ae-79cd-4941-8ffe-6dc70c0deb14@kernel.org>
Date: Mon, 3 Aug 2026 01:22:54 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next v3 1/5] bpf: do not print a newline after
 disassembly in bpf_verbose_insn()
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev, iii@linux.ibm.com,
 gimm78064@gmail.com
References: <20260802-static-zext-v3-0-3456b2604574@gmail.com>
 <20260802-static-zext-v3-1-3456b2604574@gmail.com>
Content-Language: en-GB
In-Reply-To: <20260802-static-zext-v3-1-3456b2604574@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/08/2026 21:24, Eduard Zingerman wrote:
> At the moment there are more callsites that want bpf_verbose_insn() to
> not print a newline after the instruction, than callsites that want a
> newline. Drop '\n' from disasm.c. Non-functional change.
> 
> The changes in bpftool are verified by writing a bpf program using a
> variety of instructions and comparing `prog dump xlated` output in the
> following modes: plain, opcodes, visual, visual opcodes.
> The output before and after the changes is identical.
> 
> Cc: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>


Looks good, and looking at the diff, the change makes sense. Thanks!

Reviewed-by: Quentin Monnet <qmo@kernel.org>
