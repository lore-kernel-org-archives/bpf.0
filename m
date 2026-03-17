Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369381A9F9F
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 03:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773717550; cv=none; b=Woi80LG/5rgR/kzQ/AyKuAaAPnhNYJ6t5m2rX0nGru+36Fs7es29Ce552i+81FCBH0OiHJsEk8BGSBTOZwO4NAbmjrZmUq3cSwrIFkJNhiTo1Pj6P/QYrhMV09qj0eenpVS55JknNcB9cKE3Ytj8xzrW6GolILtsWF3ptx67xGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773717550; c=relaxed/simple;
	bh=UGC2msK1snHgZsR+M5QCllcV9wCydV5GXhMTi4+VWdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgIweT8ZWxwnJcWisrxkW85VmB2sDmZxkIEovWbu1J9iP+ycAkthnZS7+c05/e9gm8mS6yOC/cxs5FQxnPv0h8k033AUwZDrYQhMw1GinDIMqksft7gCwvTGopr89xwgje7WLL2GPCM36MXKiNjhYhjLhCygKIWfBl77F99pBqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.192.132])
	by mtasvr (Coremail) with SMTP id _____wCHj6cJyLhpjskhAA--.10000S3;
	Tue, 17 Mar 2026 11:18:34 +0800 (CST)
Received: from [10.162.192.132] (unknown [10.162.192.132])
	by mail-app1 (Coremail) with SMTP id yy_KCgCnJM3rx7hpdTi1Bg--.32124S3;
	Tue, 17 Mar 2026 11:18:33 +0800 (CST)
Message-ID: <02e768eb-4073-4fe0-9fbd-200507499594@zju.edu.cn>
Date: Tue, 17 Mar 2026 11:18:04 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/2] bpf: reject bpf-to-bpf call with large offset in
 interpreter
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com,
 shenghaoyuan0928@163.com, ziye@zju.edu.cn
References: <20260316190220.113417-1-tangyazhou@zju.edu.cn>
 <20260316190220.113417-2-tangyazhou@zju.edu.cn>
 <DH4HQN1GYK0L.ZK38Z2ZS0RPO@etsalapatis.com>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <DH4HQN1GYK0L.ZK38Z2ZS0RPO@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:yy_KCgCnJM3rx7hpdTi1Bg--.32124S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBhINCmm4XQoExAABsU
X-CM-DELIVERINFO: =?B?6oxENQXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9Nr7RY+JER+qJQfAsR3eSiSS43JLB8hx5MwNSFZPG9cvf/fVad8xbDwydRfexTwccqWV
	IjxPfakpSOz6GIuWWouZGaeCyp24U8L5qzLDroP9HJ1ILIxUstJtZXov2bBk+A==
X-Coremail-Antispam: 1Uk129KBj9xXoWruF4rJr15XF48Kr1fKF1rAFc_yoW3urX_W3
	4qy3ZxZ3yqqFnrGa9xtFnrAFn7KFWfu3Z8JrZ0qa97CFyFqFykt3929a1Skry8GayxKF1q
	939rZFW3ArykCosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGO
	UUUUU

Hi Emil,

Thanks for the detailed review!

On 3/17/26 04:32, Emil Tsalapatis wrote:
> Can we maybe move the check within bpf_patch_call_args? That way, the new guard is
> right next to the typecast that necessitates it in the first place.
> 
> So basically:
> 
> bpf_patch_call_args()
> {
> 	if (insn->imm < S16_MIN || insn->imm > S16_MAX) {
> 		return -EINVAL;
> 	insn->off = (s16) insn->imm;
> 	...
> }
> 
> fixup_call_args()
> {
> 	...
> 	err = bpf_patch_call_args(insn, depth);
> 	if (err) {
> 		verbose(env, "bpf-to-bpf call offset out of range for interpreter\n");
> 		return err;
> 	}
> }
> 
> Provided this is addressed (or people have objections to the change):
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> 

Make sense, I will move the check within bpf_patch_call_args in v2 as 
suggested.

Best,

Yazhou

