Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795519303;
	b=QWPMillFxGerous1YlJTU0qMhKiE/DR+vMv/D6Rb3yPGl9loIkk//iOmW9+FmoBF8eif
	 45WHRXR8n0Tb+oYQH4Lf4BWCy0zn9L34R0yEu8EbdPYXbRgn9zTIPvjdZBLaXhZBMuS4h
	 2sTPPCJz4PxTZLcSVbK+hu+XGlGtTxmPVelrOHyKrEpGPCqHQJgaJD6C8w9QDoEZooXVm
	 BnZ7cX6N4owUTGflwARWPK0THyLKnTteyNBxl8NrQ5FLxWNdMFec8nWyXkLUjb9eyA8e+
	 kz2XCuCRgRr8Mo/LAI0YvJhECqrpiNKM3MeGKz8qXQNn8GahClB6g2wUN0q5l2Jmteg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519303;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=GhkIy80LgNxhqyYtNoMyhLZo1myuAOAZ1+zZiB+9cqg=;
	b=eL/gwfRKar5gcFUFgoaEzxv82yCET3dBrgWZXNSy6u9bk0hjt1MIq33GBRywnTHKtYeP
	 C4MxNc0SarmhFTJ0PPyJdZ1r4x/sYqj8FSJx1zSLIx3+uvdSCb6jBVKAUcr+noALGFVg6
	 yron4inh7VAKLpZyrTPve/QQSr0KancDaOD08aA1urh9HQWlAx8jIf6Y8jm+ggLzSY6+f
	 fRJHUNCYrTdxhP/aqcSpsRFfNAxFR6qBj56Jz8mXaTBU6uLTave6/VLdd3y/Cx2RDk46C
	 TxpSH7nGzZWIjMFuIIlNmH77Yn5eVftsBG2/R+66BHCH9Jq8VSMg0qUFzMgtT8jx3Og==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cMEK7JGa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.24
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010024.outbound.protection.outlook.com [52.101.193.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B0F606A33D
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 11:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94B0F606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cMEK7JGa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7mX+n0cphmhz9OfFTYripDCy+1Ul3x36/+aZ4wVb28uLOoACDKWUl4MPnaRCv6+28dyfA+pzrYfs2Myxy+Bga4MO2GTQ0iSw31Wz2fdG8rBohmNk+uSmD/XONTg2FmUirTVQoSkLgP4u5vhSVOSqOL+gIJvoTdQzpybwjkxQDQ+S4pEtnv19cHGs+gQ3iX6TH0v9wuH8D0uRa7zSbZ+JTG7wnIZ80TxVd/SZvf314g4G4JTufPr4kjJr6u1iKjJbuorvt0YUYh6A1djBT9MLvGVlh7CinXAbHWJt8JdskoUZPTXtaPmVOAcL6mG5SMisubpTU7VlCVmVsAPMQJ6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhkIy80LgNxhqyYtNoMyhLZo1myuAOAZ1+zZiB+9cqg=;
 b=oEJFHAUwaeIxkuKfK1hJc2zfbxh+iuUVoWjts6Ov+78uH1/T2FNGkF0fyZFnBBAJSqrRMKOlb5ueJa5yfi2El0j6ghREFXzA4tSWcR+SzGMnOiqmgCMRqTdIiycsXK1iOipP8PF55UDw1kSMIbPjpyHnsAW95ZB0eYpizWKHdjRjN7waH/IqtD6AefAnj0F1FPnFB975QjuxSfpE+92c49SqGF7NHWIYg/ZLYIZOy+OdsAJitPGRFxqBlUJ6Aocdfy0O7WAxSpb00qXqU0Dmy4jnn2a5jsAb2aNg3k2BUarrKhf7BQ7Tic0yMUccWffl8HKG61ZPsrAuOXB02aK37g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=163.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhkIy80LgNxhqyYtNoMyhLZo1myuAOAZ1+zZiB+9cqg=;
 b=cMEK7JGafGz/tuxq1JWrbJglL+4J1twS9M2zkjFL0zZ+8p4uAvyPe2hi+MsPVbYvJdYFDO3g7ZG27HPhy5V4r+EKEc1As/Pqz3eRv61OCmBvsxsbsra9K+f8xz7CIUR3T02A14niGAIAJEo5lih3JRkojrH6Qby0kKeUMvW0wUp3DsAzjLgSTl+vNEd9gIfmwu9tsLVQI+Yna+++OciLz2O8wLCjeC0kP3FoF8e96WEKHTzwYfX7pZNYJf8xJL1vX4K1GD/iS/VftrwH12Nd2k9OL1vbFGHt9NQ9ltHHfoQExtLAJfNM5gLTq6qlUJo8jTpdqHlZoqyYgC3MaP2Oxw==
Received: from PH7P220CA0162.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::31)
 by IA3PR12MB259910.namprd12.prod.outlook.com (2603:10b6:208:70e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Tue, 24 Nov
 2026 11:21:39 +0000
Received: from PH7PEPF00000005.namprd04.prod.outlook.com
 (2603:10b6:510:33b:cafe::15) by PH7P220CA0162.outlook.office365.com
 (2603:10b6:510:33b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 11:21:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 PH7PEPF00000005.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 11:21:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 03:21:21 -0800
Received: from [10.221.136.252] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 03:21:18 -0800
Message-ID: <ee2e279b-0127-4d69-b0d8-a76ff2da8857@nvidia.com>
Date: Tue, 24 Nov 2026 12:21:15 +0100
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
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Fix kfunc implicit arg inject type
 detection to prevent invalid pointer deref
To: <chenyuan_fl@163.com>, <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <eddyz87@gmail.com>, <yonghong.song@linux.dev>,
	<ihor.solodrai@linux.dev>, <memxor@gmail.com>, Yuan Chen
	<chenyuan@kylinos.cn>
References: <20261123055708.684107-1-chenyuan_fl@163.com>
 <20261123055708.684107-2-chenyuan_fl@163.com>
Content-Language: en-US
From: Nirmoy Das <nirmoyd@nvidia.com>
In-Reply-To: <20261123055708.684107-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF00000005:EE_|IA3PR12MB259910:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a369a2-1b29-486f-b897-08df4a1d1af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|23010399003|261026140227099003|261102123227099003|4143699003|261022105027099003|11063799006|261021121427099003|261022075727099003|56012099006|261009223027099003|261026121527099003|261028144727099003|261021123027099003|10067099003|22082099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	aMz5Geo4dV+e6+UG6zd3/u+D0RuyJdAN9reY6rgdJkeaRkmvRuKZfBlgPWrKj1i0cO/UBDNZUyvwtY5G5j3YTPcZrFr+aml5KfNh8KUhV8Z8QYIjB0mBEJKZ3OPoTZ8U3PJXdOPI+PcZJ6G7HBtTKJlE00k8aF9d2E9IbbQVwFGhHb7PPPLEvHT3TVQcHgOuQTxfP+Kqss1JEHp0xnHjRpv0ZxWD24N2Np8JX9OuMkLuH7lVAajaIKBmddfdk5jJgZid3P3qQ9dIdvt918I8s0WfB7DTkxQEyftnv7KnpUDpdr+gpfyXnN3stH+p2XzueJMZSvqpTbwymnEtHVdPydxbyj1WtDtabKUMK3wPgPgEv6VsIg1JMbBPuMsOWk7Gj0LXzosyALeeLE5UaCcmrmF0EsvxK2PVugQ04KCqJkGIuwwc+tO7jHZs3rG1jcxiRXlc/HKWufTkP4SHr9zoNMGkx3M3WkfDJ03zBRJXGXrAfwBOn+X34/NM6fGCXRXH2yA+e1UUKhF0Rg3+uZk3HwP142S6XXRLGdluae2pkmhaXe9C5xIPpstVSvvhXMwPyfKsZvi2rZlJ5J3cZlvsYWdxObshHmrIIus3+Tipac8hrLkfFM3tmREDxgWZcMioGLeMn/bziNnQgxoSh4rXXHtMwZnGAd1eaaAgkL3LkVScHyCDnxVg3gh4ZZgOXR0/Ld6B2yE0TXxPPisTgjPOog==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(23010399003)(261026140227099003)(261102123227099003)(4143699003)(261022105027099003)(11063799006)(261021121427099003)(261022075727099003)(56012099006)(261009223027099003)(261026121527099003)(261028144727099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o6+OOiJVq6enQLofCtD1sAKh/UV2y/lf0pxXYD9LN7SGyqA/Fkki5q10/dXyUXRVIElzUzQWjoM7t8iP/5ES/smK2nsFzujMq5OOkSNaufv4+ScO7L2TbqL46EaihHgCU43JrKnc6xTN5IhVh+C/0FFUHSJezFmg1PuSlOu2owJAtmF1+1Rq4d7vkCG6YYG2cuonUah5sSjsB9xsPgY/Me/PKlg8lok8LKS0XE3Fqw4rCs2ybb3evKQ8q2YlJlRCE+S4QQCArq5LEV9KebKhemd7Yj0P5vxKaz9XbsPrgn8XsfJj7XQqIU1Baxzdocg72u3fuudcrfhC3/qNuhLILUd7TXXTOEbCkuq1ZOTxAEzQAhCvZ0YtBTlnEL/hFufNqjuzTIZeLBAoDFtuwcXw2JRg/tWbzhb1QYfFA7OtpLnl/mPNCKLhYB8rhXVryEQw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:21:37.5457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a369a2-1b29-486f-b897-08df4a1d1af1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH7PEPF00000005.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB259910

Hi Yuan,


Can you please review 
https://sashiko.dev/#/message/20261123055708.684107-1-chenyuan_fl%40163.com 
findings

I see similar finding with my AI reviewer too. I have tested the series 
which is avoiding the issue as expected.


Regards,

Nirmoy

On 23.11.26 06:57, chenyuan_fl@163.com wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> When a module kfunc declares an implicit struct bpf_prog_aux * argument,
> the verifier must identify it so the kernel injects env->prog->aux into
> the correct register at runtime.  The original check used
> is_kfunc_arg_prog_aux() which calls btf_types_are_same() to compare the
> module BTF type against vmlinux.
>
> Root Cause
>
> This issue was triggered by pahole 1.30 generating module BTF with
> incorrect type information, which caused the kernel's distilled base BTF
> deduplication for modules to fail.  As a result, the module retained its
> own copy of struct bpf_prog_aux with a different BTF ID than vmlinux's
> definition.  While pahole 1.31 fixed the BTF generation issue, the kernel
> must be robust against such inconsistencies: a BTF mismatch should result
> in a clean rejection, not a kernel crash or information disclosure.
>
> When the distilled base dedup fails and btf_types_are_same() cannot match
> the module's bpf_prog_aux type against vmlinux's, is_kfunc_arg_prog_aux()
> returned false and the code fell through silently without setting
> arg_prog.  The kfunc then received whatever value was in the argument
> register and dereferenced it as a bpf_prog_aux pointer, leading to:
>
>    BUG: kernel invalid pointer dereference, address: 00000000000009e2
>    RIP: bpf_prog_get_assoc_struct_ops+0xa/0xc0
>    RDI: 0x000000000000046d (stale register value)
>
> In the observed crash the stale value was the process PID, causing a
> dereference within the unmapped NULL page.  However, an attacker able to
> control the register value -- for example by writing a BPF program that
> explicitly sets the argument register before calling a KF_IMPLICIT_ARGS
> kfunc -- could redirect the dereference to arbitrary kernel memory,
> turning this into an information disclosure.  The fix ensures the
> verifier either validates and injects the correct bpf_prog_aux pointer,
> or rejects the program outright -- no silent fallthrough that could be
> exploited.
>
> Crash Stack Trace
>
>    PID: 1133     TASK: ffff8881057d3900  CPU: 3    COMMAND: "test_progs"
>     #0 machine_kexec at ffffffff812f6e26
>     #1 __crash_kexec at ffffffff8145a788
>     #2 crash_kexec at ffffffff8145ac24
>     #3 oops_end at ffffffff812bb67c
>     #4 page_fault_oops at ffffffff813053a1
>     #5 exc_page_fault at ffffffff828e60a1
>     #6 asm_exc_page_fault at ffffffff810012a6
>        [exception RIP: bpf_prog_get_assoc_struct_ops+10]
>        RIP: ffffffff815c024a  RSP: ffffc90001b57e48  RFLAGS: 00010283
>        RAX: ffff8881057d3900  RBX: ffffc90001b57e68  RCX: ffff8881057d3900
>        RDX: 0000607d4d1768b8  RSI: 000000000000046d  RDI: 000000000000046d
>     #7 bpf_kfunc_multi_st_ops_test_1_assoc at ffffffffc0013a85 [bpf_testmod]
>     #8 bpf_trace_run2 at ffffffff814f8332
>     #9 __traceiter_sys_enter at ffffffff81415f45
>    #10 trace_syscall_enter at ffffffff81416735
>    #11 do_syscall_64 at ffffffff828e06a1
>
> Fix
>
> Split the combined is_kfunc_arg_ignore() || is_kfunc_arg_implicit() check
> in get_kfunc_arg_type() so that an implicit argument that was not
> recognized by is_kfunc_arg_prog_aux() is rejected with -EFAULT instead of
> silently skipped.  The non-bpf_prog_aux implicit arguments handled by
> bpf_fixup_kfunc_call() (obj_new, percpu_obj_new, obj_drop,
> percpu_obj_drop, refcount_acquire, list_push, rbtree_add) are explicitly
> allowed.
>
> All other KF_IMPLICIT_ARGS kfuncs take a struct bpf_prog_aux * argument,
> which is matched by the preceding is_kfunc_arg_prog_aux() check and
> injected through insn_aux_data.arg_prog, so they never reach the new
> rejection path.
>
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Fixes: 64e1360524b9 ("bpf: Verifier support for KF_IMPLICIT_ARGS")
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>   kernel/bpf/verifier.c | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14055,8 +14055,26 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
>   	if (is_kfunc_arg_prog_aux(meta->btf, &args[arg]))
>   		return ARG_PTR_TO_PROG_AUX;
>   
> -	if (is_kfunc_arg_ignore(meta->btf, &args[arg]) || is_kfunc_arg_implicit(meta, arg))
> +	if (is_kfunc_arg_ignore(meta->btf, &args[arg]))
>   		return ARG_IGNORE;
> +
> +	if (is_kfunc_arg_implicit(meta, arg)) {
> +		/*
> +		 * These kfuncs have non-prog_aux implicit arguments that
> +		 * bpf_fixup_kfunc_call() patches up after verification.
> +		 */
> +		if (is_bpf_obj_new_kfunc(meta->func_id) ||
> +		    is_bpf_percpu_obj_new_kfunc(meta->func_id) ||
> +		    is_bpf_obj_drop_kfunc(meta->func_id) ||
> +		    is_bpf_percpu_obj_drop_kfunc(meta->func_id) ||
> +		    is_bpf_refcount_acquire_kfunc(meta->func_id) ||
> +		    is_bpf_list_push_kfunc(meta->func_id) ||
> +		    is_bpf_rbtree_add_kfunc(meta->func_id))
> +			return ARG_IGNORE;
> +		verbose(env, "%s unrecognized implicit argument, possible BTF mismatch\n",
> +			reg_arg_name(env, argno));
> +		return -EFAULT;
> +	}
>   
>   	t = btf_type_skip_modifiers(meta->btf, args[arg].type, NULL);
>   
