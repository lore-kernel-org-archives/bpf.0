Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104343AB293;
	Thu, 12 Mar 2026 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773298825; cv=none; b=KggK8kLtiHtumnI4BmKNYtCGEs36VjYdK+eDwZkTos2Gl3YHmH1MhrtzhOgna5I5ln8ubsx4TiT7PJlUpUcS8IU8A4OqL5brRJSxp2GJlMjmOuZSAUrmZXpqgx3PsPLu+zp2zb5K53aXUnhiHDo3KrdqeKx5HdE9r0hzTllSE8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773298825; c=relaxed/simple;
	bh=hNi6wWRubtZ2iED2YfOkKtPZpeXpYokXqHRTOIEL/Ac=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OixOeTyTUYyxGhy7nU5duDSJnCK+PQh5nf5IEHsx8JscoyJZjAN9585P3eFe7iQhjBtXAQeSOc6KVhOb6ZQ1ONZgJW3FP+Jh4SRSmcgp6Mx4XG1iTbjRVelmIUbA/To9flRSFfWXNzE06Uxsg3cc9KUgP+2cskbxCexSQrkotLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxacJ4ZLJpaD0aAA--.10629S3;
	Thu, 12 Mar 2026 15:00:08 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCx98BtZLJpC69TAA--.14415S3;
	Thu, 12 Mar 2026 14:59:58 +0800 (CST)
Subject: Re: [PATCH bpf-next v1 1/2] selftests/bpf: Check alignment flag if
 expected result is REJECT
To: Emil Tsalapatis <emil@etsalapatis.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Hengqi Chen <hengqi.chen@gmail.com>,
 Paul Chaignon <paul.chaignon@gmail.com>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260310064507.4228-1-yangtiezhu@loongson.cn>
 <20260310064507.4228-2-yangtiezhu@loongson.cn>
 <DH02R7I6EAUH.16649BMB7V1N8@etsalapatis.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <fe04d981-fc83-0ba6-4dee-8fc0c953e09f@loongson.cn>
Date: Thu, 12 Mar 2026 14:59:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <DH02R7I6EAUH.16649BMB7V1N8@etsalapatis.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx98BtZLJpC69TAA--.14415S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9fXoW3tFy7JFWUtFWxXryfAw15ZFc_yoW8GFWDAo
	Wakw47u3yfJ347Ca1UA3WxCr4Iy345GF15XFsIgF45ua15ZrWfur1rA3y3G3Z0ga1j939I
	qa95ta4kZF1xZrnrl-sFpf9Il3svdjkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUO87kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOiSdUUU
	UU=

Hi Emil and Paul,

On 2026/3/11 下午11:56, Emil Tsalapatis wrote:
> On Tue Mar 10, 2026 at 2:45 AM EDT, Tiezhu Yang wrote:
>> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set unconditionally for the
>> most archs such as x86_64, aarch64, ppc64el and s390x, but this config
>> may be not set by users for riscv64 and loongarch64.
>>
>> If CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is not set, the BPF verifier
>> detects if a program has unaligned access and then rejects them. So it
>> should also check the flag F_NEEDS_EFFICIENT_UNALIGNED_ACCESS if the
>> expected result is REJECT and set alignment_prevented_execution as 1,
>> then the message "(NOTE: not executed due to unknown alignment)" can
>> be printed for some testcases of test_verifier to reflect the reality.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   tools/testing/selftests/bpf/test_verifier.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
>> index a8ae03c57bba..a1ae2f044e96 100644
>> --- a/tools/testing/selftests/bpf/test_verifier.c
>> +++ b/tools/testing/selftests/bpf/test_verifier.c
>> @@ -1640,6 +1640,11 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
>>   			printf("FAIL\nUnexpected success to load!\n");
>>   			goto fail_log;
>>   		}
>> +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>> +		if (fd_prog < 0 &&
>> +		    (test->flags & F_NEEDS_EFFICIENT_UNALIGNED_ACCESS))
>> +			alignment_prevented_execution = 1;
>> +#endif
> 
> This doesn't look like it's breaking anything, but it will cause all
> tests with F_NEEDS_EFFICIENT_UNALIGNED ACCESS to be reported as failing
> due to unaligned accesses even if they actually failed due to expected
> errors at load time.
> 
> Which test programs is this fix targeted towards? Can't we just skip
> those tests for riscv/loongarch instead of adding this workaround?

Thanks for your reviews.

It does not fix any failed testcases, the testcases passed without
and with this patch. It only affects the output for some testcases
such as test_verifier 14, 153, 190, 191, 193, 197, 200, 201, 202,
204, 255, 256, 295, 297, 298, 300, 301, 302, 307, 308, 331, 341,
342, 475, 477, 500, 512, 514, 515, 517, 520, 522, 523, 525.

For example, for the test_verifier 14,
verifier/atomic_cmpxchg.c:215
"Dest pointer in r0 - succeed, check 5",
if remove ".flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,",
here is the test result if HAVE_EFFICIENT_UNALIGNED_ACCESS is not set:

$ sudo ./test_verifier 14
#14/u Dest pointer in r0 - succeed, check 5 OK
#14/p Dest pointer in r0 - succeed, check 5 FAIL
Unexpected verifier log!
EXP: R0 invalid mem access
RES:
FAIL
Unexpected error message!
	EXP: R0 invalid mem access
	RES: misaligned access off (0x0; 0xffffffff)+-8 size 4
verification time 27 usec
stack depth 8
processed 5 insns (limit 1000000) max_states_per_insn 0 total_states 0 
peak_states 0 mark_read 0

misaligned access off (0x0; 0xffffffff)+-8 size 4
verification time 27 usec
stack depth 8
processed 5 insns (limit 1000000) max_states_per_insn 0 total_states 0 
peak_states 0 mark_read 0
Summary: 1 PASSED, 0 SKIPPED, 1 FAILED

It seems that this is because the program has unaligned accesses,
but the kernel sets CONFIG_ARCH_STRICT_ALIGN by default to enable
-mstrict-align to prevent unaligned accesses.

So I think add "(NOTE: not executed due to unknown alignment)" to the
output is reasonable. Something I missed?

Without this patch:

   sudo ./test_verifier > log.before

With this patch:

   sudo ./test_verifier > log.after

Here is the diff:

$ diff -uNr log.before log.after
--- log.before	2026-03-12 14:19:04.119957887 +0800
+++ log.after	2026-03-12 14:23:03.468251328 +0800
@@ -26,7 +26,7 @@
  #12/p Dest pointer in r0 - succeed, check 3 OK
  #13/u Dest pointer in r0 - succeed, check 4 OK
  #13/p Dest pointer in r0 - succeed, check 4 OK
-#14/p Dest pointer in r0 - succeed, check 5 OK
+#14/p Dest pointer in r0 - succeed, check 5 OK (NOTE: not executed due 
to unknown alignment)
  #15/u BPF_ATOMIC_FETCH_ADD smoketest - 64bit OK
  #15/p BPF_ATOMIC_FETCH_ADD smoketest - 64bit OK
  #16/u BPF_ATOMIC_FETCH_ADD smoketest - 32bit OK
@@ -254,7 +254,7 @@
  #151/p calls: callee using wrong args2 OK
  #152/u calls: callee using two args OK
  #152/p calls: callee using two args OK
-#153/p calls: callee changing pkt pointers OK
+#153/p calls: callee changing pkt pointers OK (NOTE: not executed due 
to unknown alignment)
  #154/u calls: ptr null check in subprog OK
  #154/p calls: ptr null check in subprog OK
  #155/p calls: two calls with args OK
@@ -293,21 +293,21 @@
  #187/p calls: ambiguous return value OK
  #188/p calls: two calls that return map_value OK
  #189/p calls: two calls that return map_value with bool condition OK
-#190/p calls: two calls that return map_value with incorrect bool check OK
-#191/p calls: two calls that receive map_value via 
arg=ptr_stack_of_caller. test1 OK
+#190/p calls: two calls that return map_value with incorrect bool check 
OK (NOTE: not executed due to unknown alignment)
+#191/p calls: two calls that receive map_value via 
arg=ptr_stack_of_caller. test1 OK (NOTE: not executed due to unknown 
alignment)
  #192/p calls: two calls that receive map_value via 
arg=ptr_stack_of_caller. test2 OK
-#193/p calls: two jumps that receive map_value via 
arg=ptr_stack_of_jumper. test3 OK
+#193/p calls: two jumps that receive map_value via 
arg=ptr_stack_of_jumper. test3 OK (NOTE: not executed due to unknown 
alignment)
  #194/p calls: two calls that receive map_value_ptr_or_null via arg. 
test1 OK
  #195/p calls: two calls that receive map_value_ptr_or_null via arg. 
test2 OK
  #196/p calls: pkt_ptr spill into caller stack OK (NOTE: not executed 
due to unknown alignment)
-#197/p calls: pkt_ptr spill into caller stack 2 OK
+#197/p calls: pkt_ptr spill into caller stack 2 OK (NOTE: not executed 
due to unknown alignment)
  #198/p calls: pkt_ptr spill into caller stack 3 OK (NOTE: not executed 
due to unknown alignment)
  #199/p calls: pkt_ptr spill into caller stack 4 OK (NOTE: not executed 
due to unknown alignment)
-#200/p calls: pkt_ptr spill into caller stack 5 OK
-#201/p calls: pkt_ptr spill into caller stack 6 OK
-#202/p calls: pkt_ptr spill into caller stack 7 OK
+#200/p calls: pkt_ptr spill into caller stack 5 OK (NOTE: not executed 
due to unknown alignment)
+#201/p calls: pkt_ptr spill into caller stack 6 OK (NOTE: not executed 
due to unknown alignment)
+#202/p calls: pkt_ptr spill into caller stack 7 OK (NOTE: not executed 
due to unknown alignment)
  #203/p calls: pkt_ptr spill into caller stack 8 OK (NOTE: not executed 
due to unknown alignment)
-#204/p calls: pkt_ptr spill into caller stack 9 OK
+#204/p calls: pkt_ptr spill into caller stack 9 OK (NOTE: not executed 
due to unknown alignment)
  #205/p calls: caller stack init to zero or map_value_or_null OK
  #206/u calls: stack init to zero and pruning OK
  #206/p calls: stack init to zero and pruning OK
@@ -390,8 +390,8 @@
  #253/p check skb->hash half load permitted OK
  #254/u check skb->hash half load permitted 2 OK
  #254/p check skb->hash half load permitted 2 OK
-#255/p check skb->hash half load not permitted, unaligned 1 OK
-#256/p check skb->hash half load not permitted, unaligned 3 OK
+#255/p check skb->hash half load not permitted, unaligned 1 OK (NOTE: 
not executed due to unknown alignment)
+#256/p check skb->hash half load not permitted, unaligned 3 OK (NOTE: 
not executed due to unknown alignment)
  #257/p check cb access: half, wrong type OK
  #258/u check cb access: word OK
  #258/p check cb access: word OK
@@ -454,20 +454,20 @@
  #292/p pkt_end < pkt taken check OK (NOTE: not executed due to unknown 
alignment)
  #293/p valid 1,2,4,8-byte reads from bpf_sk_lookup OK
  #294/p invalid 8-byte read from bpf_sk_lookup family field OK
-#295/p invalid 8-byte read from bpf_sk_lookup protocol field OK
+#295/p invalid 8-byte read from bpf_sk_lookup protocol field OK (NOTE: 
not executed due to unknown alignment)
  #296/p invalid 8-byte read from bpf_sk_lookup remote_ip4 field OK
-#297/p invalid 8-byte read from bpf_sk_lookup remote_ip6 field OK
-#298/p invalid 8-byte read from bpf_sk_lookup remote_port field OK
+#297/p invalid 8-byte read from bpf_sk_lookup remote_ip6 field OK 
(NOTE: not executed due to unknown alignment)
+#298/p invalid 8-byte read from bpf_sk_lookup remote_port field OK 
(NOTE: not executed due to unknown alignment)
  #299/p invalid 8-byte read from bpf_sk_lookup local_ip4 field OK
-#300/p invalid 8-byte read from bpf_sk_lookup local_ip6 field OK
-#301/p invalid 8-byte read from bpf_sk_lookup local_port field OK
-#302/p invalid 8-byte read from bpf_sk_lookup ingress_ifindex field OK
+#300/p invalid 8-byte read from bpf_sk_lookup local_ip6 field OK (NOTE: 
not executed due to unknown alignment)
+#301/p invalid 8-byte read from bpf_sk_lookup local_port field OK 
(NOTE: not executed due to unknown alignment)
+#302/p invalid 8-byte read from bpf_sk_lookup ingress_ifindex field OK 
(NOTE: not executed due to unknown alignment)
  #303/p invalid 4-byte read from bpf_sk_lookup sk field OK
  #304/p invalid 2-byte read from bpf_sk_lookup sk field OK
  #305/p invalid 1-byte read from bpf_sk_lookup sk field OK
  #306/p invalid 4-byte read past end of bpf_sk_lookup OK
-#307/p invalid 4-byte unaligned read from bpf_sk_lookup at odd offset OK
-#308/p invalid 4-byte unaligned read from bpf_sk_lookup at even offset OK
+#307/p invalid 4-byte unaligned read from bpf_sk_lookup at odd offset 
OK (NOTE: not executed due to unknown alignment)
+#308/p invalid 4-byte unaligned read from bpf_sk_lookup at even offset 
OK (NOTE: not executed due to unknown alignment)
  #309/p invalid 8-byte write to bpf_sk_lookup OK
  #310/p invalid 4-byte write to bpf_sk_lookup OK
  #311/p invalid 2-byte write to bpf_sk_lookup OK
@@ -507,7 +507,7 @@
  #329/p direct map access, write test 4 OK
  #330/u direct map access, write test 5 OK
  #330/p direct map access, write test 5 OK
-#331/p direct map access, write test 6 OK
+#331/p direct map access, write test 6 OK (NOTE: not executed due to 
unknown alignment)
  #332/u direct map access, write test 7 OK
  #332/p direct map access, write test 7 OK
  #333/u direct map access, write test 8 OK
@@ -526,8 +526,8 @@
  #339/p direct map access, write test 14 OK
  #340/u direct map access, write test 15 OK
  #340/p direct map access, write test 15 OK
-#341/p direct map access, write test 16 OK
-#342/p direct map access, write test 17 OK
+#341/p direct map access, write test 16 OK (NOTE: not executed due to 
unknown alignment)
+#342/p direct map access, write test 17 OK (NOTE: not executed due to 
unknown alignment)
  #343/u direct map access, write test 18 OK
  #343/p direct map access, write test 18 OK
  #344/u direct map access, write test 19 OK
@@ -723,9 +723,9 @@
  #472/p test14 ld_imm64: reject 2nd imm != 0 OK
  #473/p map_kptr: BPF_ST imm != 0 OK
  #474/p map_kptr: size != bpf_size_to_bytes(BPF_DW) OK
-#475/p map_kptr: map_value non-const var_off OK
+#475/p map_kptr: map_value non-const var_off OK (NOTE: not executed due 
to unknown alignment)
  #476/p map_kptr: bpf_kptr_xchg non-const var_off OK
-#477/p map_kptr: unaligned boundary load/store OK
+#477/p map_kptr: unaligned boundary load/store OK (NOTE: not executed 
due to unknown alignment)
  #478/p map_kptr: reject var_off != 0 OK
  #479/p map_kptr: unref: reject btf_struct_ids_match == false OK
  #480/p map_kptr: unref: loaded pointer marked as untrusted OK
@@ -748,7 +748,7 @@
  #497/p precise: cross frame pruning OK
  #498/p precise: ST zero to stack insn is supported OK
  #499/p precise: STX insn causing spi > allocated_stack OK
-#500/p precise: mark_chain_precision for ARG_CONST_ALLOC_SIZE_OR_ZERO OK
+#500/p precise: mark_chain_precision for ARG_CONST_ALLOC_SIZE_OR_ZERO 
OK (NOTE: not executed due to unknown alignment)
  #501/p precise: program doesn't prematurely prune branches OK
  #502/p scale: scale test 1 OK
  #503/p scale: scale test 2 OK
@@ -760,19 +760,19 @@
  #509/p sleepable uprobe accept OK
  #510/p sleepable raw tracepoint reject OK
  #511/p wide store to bpf_sock_addr.user_ip6[0] Did not run the program 
(not supported) OK
-#512/p wide store to bpf_sock_addr.user_ip6[1] OK
+#512/p wide store to bpf_sock_addr.user_ip6[1] OK (NOTE: not executed 
due to unknown alignment)
  #513/p wide store to bpf_sock_addr.user_ip6[2] Did not run the program 
(not supported) OK
-#514/p wide store to bpf_sock_addr.user_ip6[3] OK
-#515/p wide store to bpf_sock_addr.msg_src_ip6[0] OK
+#514/p wide store to bpf_sock_addr.user_ip6[3] OK (NOTE: not executed 
due to unknown alignment)
+#515/p wide store to bpf_sock_addr.msg_src_ip6[0] OK (NOTE: not 
executed due to unknown alignment)
  #516/p wide store to bpf_sock_addr.msg_src_ip6[1] Did not run the 
program (not supported) OK
-#517/p wide store to bpf_sock_addr.msg_src_ip6[2] OK
+#517/p wide store to bpf_sock_addr.msg_src_ip6[2] OK (NOTE: not 
executed due to unknown alignment)
  #518/p wide store to bpf_sock_addr.msg_src_ip6[3] OK
  #519/p wide load from bpf_sock_addr.user_ip6[0] Did not run the 
program (not supported) OK
-#520/p wide load from bpf_sock_addr.user_ip6[1] OK
+#520/p wide load from bpf_sock_addr.user_ip6[1] OK (NOTE: not executed 
due to unknown alignment)
  #521/p wide load from bpf_sock_addr.user_ip6[2] Did not run the 
program (not supported) OK
-#522/p wide load from bpf_sock_addr.user_ip6[3] OK
-#523/p wide load from bpf_sock_addr.msg_src_ip6[0] OK
+#522/p wide load from bpf_sock_addr.user_ip6[3] OK (NOTE: not executed 
due to unknown alignment)
+#523/p wide load from bpf_sock_addr.msg_src_ip6[0] OK (NOTE: not 
executed due to unknown alignment)
  #524/p wide load from bpf_sock_addr.msg_src_ip6[1] Did not run the 
program (not supported) OK
-#525/p wide load from bpf_sock_addr.msg_src_ip6[2] OK
+#525/p wide load from bpf_sock_addr.msg_src_ip6[2] OK (NOTE: not 
executed due to unknown alignment)
  #526/p wide load from bpf_sock_addr.msg_src_ip6[3] OK
  Summary: 777 PASSED, 0 SKIPPED, 0 FAILED

Thanks,
Tiezhu

