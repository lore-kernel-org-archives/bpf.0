Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792970966;
	b=dLPIiEOw8fy2f7IwgoskqaaXcC+SN/vHe03zPMI+S+SCTFHfKue45mOdY7A9c7R3G4ic
	 cDZILyX3q9qY4j5X6LCqmbtobIbmEJy+QPCwlKYWJjfvsfLtnW8lr6gxq+fKxfQask7+Z
	 hJ13cd6tK4Ohr0mUn+V4XKAtd4Eie67eGm7x+zYPy04IGNwP830clGdvTlfOV75upgwAa
	 UetBUGrTjVNaMhhg+4+TIO9HtU5tmFqy3qwkhAsle3rbNtrfg3zujS9iTXbspGhJg8BW0
	 3by8znuZWV8cia7KAecRC6u/41ywHID2sQCax/bGwIda/YXYPuCmIzDQCgFWyC+c9ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792970966;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=jYOFBLSGEnNdhnGY76tZesZu7gNZ9rzFYzDOwois3Cg=;
	b=Y84H3Hoc4cvqS6X2INPxAaI4mEry4SIJ0tOV+9JN3GFFj7nGnreoxjikh9/eYtcl3x7B
	 w/xhXvnzzpYtx1vYp98dRZ9eYrmS3WQvr9nBsYWqesA9H6iSEV0PaVboX64cbYLVrGKOO
	 i7vWU9gRhc1fXRG962dNqGbgy1p1hqWvI2fW+vtAr7RezoRipgFQ+PSWU886t24XHHGqt
	 kgV0G4RwNkc3YjeUx8Ijb7CQTvh2LVvrA0FodqccoxVuIGgDvlCB/LrM775aKB7NqRfXB
	 ZoHlWStpbJeKa9MXKi2hACdjKgxzXQvI/wY7mClWEfPcV4kZBeqsDIS/msfPn2lSpiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IMTZvbtA;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FEF606A31A;
	Sun, 25 Oct 2026 23:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1FEF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IMTZvbtA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=jYOFBLSGEnNdhnGY76tZesZu7gNZ9rzFYzDOwois3Cg=; b=IMTZvbtAq5pXyO+aBUA877UWDg
	2eh195KrazJoEWqz+idrnFJeg7qYmOnC81FS2AWuaKFwlxwUpwUgyxE1Ff+t9uWC3DR70JeMJSbV4
	QdUOUF+BBYD08pSfkr/KkK9wBpcU2tyuRjxzWrxWWEdYfc5+5qOsvIxDBbUDeCsmhVmIPcYz4ECqy
	XSpJH2J7PMetNL7E5PcwEC0AcFLuDGMh8h7zQ5HL2NcXKGzz4ksUAzU1D/58oH0rMjSKcK9dmFGYi
	i6Xuo13E1yUWZfJ56oMA/jCIgCES+8pmH/62YIc1NhS6rPBzDza82rggebR2j2Tp36DGe6kKjoMDW
	5iSta3yA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL7eL-00000001VBZ-2PkI;
	Sun, 25 Oct 2026 23:29:13 +0000
Message-ID: <94b36a91-4fe8-480e-a49a-23a81cdcdc60@infradead.org>
Date: Sun, 25 Oct 2026 16:29:11 -0700
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
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to
 /proc/kallsyms
To: Samuel Wu <wusamuel@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
References: <20261023001603.560210-8-wusamuel@google.com>
 <20261023001603.560210-9-wusamuel@google.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261023001603.560210-9-wusamuel@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/22/26 5:16 PM, Samuel Wu wrote:

...
> ---
>  include/uapi/linux/fs.h |  41 +++++++++++++
>  kernel/kallsyms.c       | 132 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 173 insertions(+)
> 
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 34c6f219462a..b43f227dad0e 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -674,6 +674,47 @@ struct procmap_query {
>  	__u64 build_id_addr;		/* in */
>  };
>  
> +/* /proc/kallsyms ioctl */
> +#define KALLSYMS_QUERY	_IOWR(PROCFS_IOCTL_MAGIC, 18, struct kallsyms_query)
...


Documentation/userspace/ioctl/ioctl-number.rst doesn't seem to know
about PROCFS_IOCTL_MAGIC and what range of @nr values that it uses.

Please update it.

-- 
~Randy

