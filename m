Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794622966;
	b=r/Ifrk3WHVaiUTAlpg/2k+4qE83/DOk71AN6y8Cm5rL2Y+XExkv55w2ml1fUcJKW46+F
	 fBDp4TeUPETnG2ed2OjAxrmeMZpth4J5+L9EFqEV+SlTsey9kKi24SNi+0hLyC8dZUq+E
	 hynIwvy/e1AThMdmEFsBPPb5goNi3nJvyRX6BZRjX9qfx10LekqnHgvMW3bCHCYYPvTk8
	 BenvfnP4XMmYAaFOYR/rP9sFnx9KZy3bUIO6ZAEGlXX+ASOC1m+JTVadUvkCoyVD2zuHq
	 zRqdoQkV7pO5LQ1fQTrgSJC2jMY55GQMkx0NOM9aaAeyn00b4SEwc9G0XKYdf7FMrfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794622966;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=KYH8GK+3gKCbe8AFviicg/gKMInfl4KxsgkMklQwI0I=;
	b=Nm7SN5UuX0G+dsnNz599PQETxz/3YgPK7jJsRHhk2tgyVn+sn3UP/bff2v1J2ZBNdlxV
	 5ZtQfdcWo986+K6zs8YWEB7N1b2xxuHOiX5GpOZyRbjFJpjlwNNMbJPYyIbIAMp5HKZqQ
	 O71xwTnbEAG4Q+PEua5VGcAP4EpyIG8vWb6Q97TUbQ9slSuvnV85KbouykOEcdKdP6QV0
	 hzbAw86gtuY3fkaMdryo2jKxZK3C6wMYaD8CAF7fan1PZLJuR/qzoQBZZs1QHAnOtXlYV
	 DeZVrBxwf/M7bup8CZPF4UuTDGCLa2mcVZYmDeo2HCZLniy9psJ/tmkfom+goY2rR0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rMuN7IjH;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2CB606A323;
	Sat, 14 Nov 2026 02:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F2CB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rMuN7IjH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=KYH8GK+3gKCbe8AFviicg/gKMInfl4KxsgkMklQwI0I=; b=rMuN7IjHqau/xc2v+L3+j7J4jB
	17LlIfCgQ9gZKjdEwR0HXIgEkj3NXbY5xvNTsPXiBiBfWA7YMTlJ7vBYcuHX96ZzfRi0CTxMs86wl
	szbPVi6oRy0+B+JhKwwaPFbRr0o0r2J9sBRAnfvxJ9HqKtDTT0ekYY8C0ExAavytJEuPy3UAsP/+H
	jtp3ovKisKoc+9HBVJkeYRwch5zTVe0ensOeH+7US5c+8EmqjHPgOFqeEtk9N0MQMUEAjwUvcWpoB
	UyCXCYk39aCtWB0QK+nkmZcnkxvlWVz0csE1AnKnDzudY0naphVcLgXLHfs6Kf163UQupHv8uGenu
	cBJGZsIw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS3Pd-0000000F6qc-1hxV;
	Sat, 14 Nov 2026 02:22:41 +0000
Message-ID: <43fb0823-e3c7-4946-98f1-7d0b2b0a1f01@infradead.org>
Date: Fri, 13 Nov 2026 18:22:36 -0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/9] Documentation: ioctl-number: Add
 PROCFS_IOCTL_MAGIC range 0x10-0x11
To: Samuel Wu <wusamuel@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek
 <pmladek@suse.com>, David Laight <david.laight.linux@gmail.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-modules@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
References: <20261113221248.3535369-11-wusamuel@google.com>
 <20261113221248.3535369-12-wusamuel@google.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261113221248.3535369-12-wusamuel@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/13/26 2:12 PM, Samuel Wu wrote:
> PAGEMAP_SCAN (0x10) and PROCMAP_QUERY (0x11) use PROCFS_IOCTL_MAGIC.
> ext4 uses the same numbers on other files, so mark the row as a
> conflict.
> 
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Samuel Wu <wusamuel@google.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/userspace-api/ioctl/ioctl-number.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index dbe462040999..fbc3537fc9ee 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -248,6 +248,7 @@ Code  Seq#    Include File                                             Comments
>  'f'   00-0F  fs/ext4/ext4.h                                            conflict!
>  'f'   00-0F  linux/fs.h                                                conflict!
>  'f'   00-0F  fs/ocfs2/ocfs2_fs.h                                       conflict!
> +'f'   10-11  linux/fs.h                                                conflict! procfs ioctls (PROCFS_IOCTL_MAGIC)
>  'f'   13-27  linux/fscrypt.h
>  'f'   81-8F  linux/fsverity.h
>  'g'   00-0F  linux/usb/gadgetfs.h

-- 
~Randy
