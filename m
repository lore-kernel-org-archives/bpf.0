Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A212C326D;
	Fri,  7 Aug 2026 01:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786067660; cv=none; b=NaRcXGin9Fdf17r64Brcw1fvZHVQQ+SZZz5DoySB+h0pgvQ4zvgwirNzYhcgMpUOxRhCz6boegUTwkqFIX/U8Tu9IrGKR8iz9ZkTTiVsH02P2pSeRKaBunig6ZlBcDvx6im2H/KxP35D2fPSmF0/nmbn9ZEis+qBatLt4HdRz1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786067660; c=relaxed/simple;
	bh=Dki6NqBruKndxMNgT5dyFppwBJaeC/paWC2HzCOseUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YxbErCVpyLXHBVBbdSJZ3z4QxjzlvDl9jvV2izL6NPhefkOaPR4VWhNAe3AKEg+UqlIvOAiXxmnY1U9DsyL2vNbOnpjiisz6cqAYXYMXuETWR/ELamsGLocWxizuCwLp0kxdsXka9gj78U0ibC0yPPBze9saF7p2FoLh1N4C3Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CUd6D6rz; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CUd6D6rz"
Message-ID: <05084a53-a1a4-4e60-bdd7-6fd16ef6a029@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786067655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67Kicf9WT4kjE79wuLJ4NaDZ2qJ1L7TiOIATh55V8Lc=;
	b=CUd6D6rzmd+s48TboJYTV45ifl8rC0y4HKW/x0GxCQXk2ef8ABU7L+iG0ewPJUSeTMA9xn
	tq8GzUPlyvusoL6oe0GRygrxLhlNfDAzd3PTj+W6b4ibIKMwoJORjWtsO7muV0ECSeadU2
	SaYjJ3zHpMxhA7XTXOp5kOCJmBclqqY=
Date: Fri, 7 Aug 2026 09:53:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/5] net: Add connect_socket() helper
To: Mahe Tardy <mahe.tardy@gmail.com>, bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org,
 liamwisehart@meta.com, martin.lau@linux.dev, pabeni@redhat.com,
 song@kernel.org, netdev@vger.kernel.org, sdf.kernel@gmail.com,
 ameryhung@gmail.com, kuniyu@google.com, memxor@gmail.com
References: <20260806182234.380833-1-mahe.tardy@gmail.com>
 <20260806182234.380833-2-mahe.tardy@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260806182234.380833-2-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 8/7/26 2:22 AM, Mahe Tardy wrote:
> Add a helper that connects an existing socket while invoking the LSM
> hook. Reuse it in __sys_connect_file() to avoid duplicating the connect
> logic. Other socket operations have equivalent helpers that trigger the
> appropriate LSM hooks that can be reused, this one was the only one
> missing.
>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>   include/linux/socket.h |  2 ++
>   net/socket.c           | 32 ++++++++++++++++++--------------
>   2 files changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/socket.h b/include/linux/socket.h
> index 2a8d7b14f1d1..8964528e3823 100644
> --- a/include/linux/socket.h
> +++ b/include/linux/socket.h
> @@ -461,6 +461,8 @@ extern struct file *__sys_socket_file(int family, int type, int protocol);
>   extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen);
>   extern int __sys_bind_socket(struct socket *sock, struct sockaddr_storage *address,
>   			     int addrlen);
> +extern int connect_socket(struct socket *sock, struct sockaddr_storage *addr,
> +				int addrlen, int flags);
>   extern int __sys_connect_file(struct file *file, struct sockaddr_storage *addr,
>   			      int addrlen, int file_flags);
>   extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
> diff --git a/net/socket.c b/net/socket.c
> index 63c69a0fa74e..126a674f534d 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2103,6 +2103,20 @@ SYSCALL_DEFINE3(accept, int, fd, struct sockaddr __user *, upeer_sockaddr,
>   	return __sys_accept4(fd, upeer_sockaddr, upeer_addrlen, 0);
>   }
>
> +int connect_socket(struct socket *sock, struct sockaddr_storage *address,
> +			 int addrlen, int flags)
> +{


Please fix the checkpatch warning if revise

CHECK: extern prototypes should be avoided in .h files
#27: FILE: include/linux/socket.h:464:
+extern int connect_socket(struct socket *sock, struct sockaddr_storage 
*addr,

CHECK: Alignment should match open parenthesis
#28: FILE: include/linux/socket.h:465:
+extern int connect_socket(struct socket *sock, struct sockaddr_storage 
*addr,
+                int addrlen, int flags);

CHECK: Alignment should match open parenthesis
#41: FILE: net/socket.c:2107:
+int connect_socket(struct socket *sock, struct sockaddr_storage *address,
+             int addrlen, int flags)

