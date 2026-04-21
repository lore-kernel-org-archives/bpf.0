Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF103D646C
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776730; cv=none; b=SjGyItQwn9dJzk6UQi5llN6Xia0lIZlXbwh/20yaZX9bovhVgPfWnRDbSyquDQn2g31ft/BBB1mPoRrAsrhpdbljC3dfegtzscOlG/H1jo8mTeUt4EYbQqgQDjs14KafZZnRckKsuCwszIrBC58SoxPr1zNfxlKbPPgwwGFiQ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776730; c=relaxed/simple;
	bh=ryuOGLNpZGoO4SmrDC5WEay+GG5hhmzBR082PoEkLq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ueik9i/ix4+j0u8n78VSNVwvzXyj4u4hhImmzx7lQUNotPg7HESNyMHKM2uq8JCXDrj8vFbCWOBTu6WJlFa+cHnxiPUwj+jNUuCaU1n3DWUK1Ka7xUxxqVBsp8oQ3m0SrpixsuJkK3lh5/vUVJCyfptzZWnlKDSWA/GSgPHcb3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4g0Mxy246tzYQtL3
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 21:04:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8B945405D2
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 21:05:18 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgBnU_4NdudpXKvTBA--.8506S2;
	Tue, 21 Apr 2026 21:05:18 +0800 (CST)
Message-ID: <ea1d6de6-55b0-4478-94e3-83733788e7c9@huaweicloud.com>
Date: Tue, 21 Apr 2026 21:05:17 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Uninitialized Stack Variable / NULL Pointer Dereference in
 __sys_socket_create via BPF LSM hooks
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@google.com>, mattbobrowski@google.com
Cc: 2022090917019@std.uestc.edu.cn, M202472210@hust.edu.cn,
 bpf@vger.kernel.org, daniel@iogearbox.net, dddddd@hust.edu.cn,
 dzm91@hust.edu.cn, edumazet@google.com,
 hust-os-kernel-patches@googlegroups.com, jiayuan.chen@linux.dev
References: <aedAqdeuVqLq4hDQ@google.com>
 <20260421100231.1834988-1-kuniyu@google.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260421100231.1834988-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnU_4NdudpXKvTBA--.8506S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF48Wry7JFWDXFWxJryxKrg_yoW5CF1fpr
	48Gr9rAr4qya9Fgry3tan3AFWay3Wjq3y2k3s5Ar10yw4DJrnaqa45KrWUurWakFykJw10
	vr429F4qv3y2qFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 4/21/2026 5:59 PM, Kuniyuki Iwashima wrote:

[...]

> I think the issue here is that __sock_create() handles
> a positive retval as error only for two LSM hooks,
> security_socket_create() and security_socket_post_create(),
> which is different from __sys_socket_create()'s expectation.
> 
> sock_create()(_kern()) callers are supposed to check the retval
> first before accessing the passed &sock pointer, so I don't
> think leaving it uninitialised itself is a problem and I'd
> rather ignore >0 value as allowed.
> 
> And I found a good place in verifier to reject the repro.
> 
> ---8<---
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9e4980128151..19cc4ed8c389 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10448,6 +10448,11 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>   				verbose(env, "BPF_LSM_CGROUP that attach to void LSM hooks can't modify return value!\n");
>   				return -EINVAL;
>   			}
> +
> +			if (regs[BPF_REG_1].s32_max_value > 0) {
> +				verbose(env, "BPF_LSM_CGROUP can't return a positive value!\n");
> +				return -EINVAL;
> +			}
>   		}
>   		break;
>   	case BPF_FUNC_dynptr_data:
> diff --git a/net/socket.c b/net/socket.c
> index 22a412fdec07..d40aea527f66 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1617,7 +1617,7 @@ int __sock_create(struct net *net, int family, int type, int protocol,
>   	}
>   
>   	err = security_socket_create(family, type, protocol, kern);
> -	if (err)
> +	if (err < 0)
>   		return err;
>   
>   	/*
> @@ -1685,7 +1685,7 @@ int __sock_create(struct net *net, int family, int type, int protocol,
>   	 */
>   	module_put(pf->owner);
>   	err = security_socket_post_create(sock, family, type, protocol, kern);
> -	if (err)
> +	if (err < 0)
>   		goto out_sock_release;
>   	*res = sock;
>   
> ---8<---
> 
>

Since the value set by bpf_set_retval() is the actual LSM hook return value,
I think we should check it directly against the hook’s valid return range,
rather than making a specific change for the socket_create hook.

The diff below should work:

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10449,6 +10449,9 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
         case BPF_FUNC_set_retval:
                 if (prog_type == BPF_PROG_TYPE_LSM &&
                     env->prog->expected_attach_type == BPF_LSM_CGROUP) {
+                       struct bpf_reg_state *reg;
+                       struct bpf_retval_range range;
+
                         if (!env->prog->aux->attach_func_proto->type) {
                                 /* Make sure programs that attach to void
                                  * hooks don't try to modify return value.
@@ -10456,6 +10459,13 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
                                 verbose(env, "BPF_LSM_CGROUP that attach to void LSM hooks can't modify return value!\n");
                                 return -EINVAL;
                         }
+
+                       reg = reg_state(env, BPF_REG_1);
+                       bpf_lsm_get_retval_range(env->prog, &range);
+                       if (!retval_range_within(range, reg)) {
+                               verbose_invalid_scalar(env, reg, range, "At bpf_set_retval", "R1");
+                               return -EINVAL;
+                       }
                 }
                 break;
         case BPF_FUNC_dynptr_data:

