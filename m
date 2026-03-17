Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD49275B18;
	Tue, 17 Mar 2026 01:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773712625; cv=none; b=JrvS6+jRbGoyepRaKNUX5Glv/mbxFKm9D5Ul+c4clhzdtAYia4nyBFelIAGnUtGifXq8VLapSHVljZ8OxOEHe6xqLfUVWCBnoCkg22SGonZp3U4LpI435VfvDDgrtRf8+2VoSAx94EnMdeA6JnQPAnG9LOFyWYGasl9q2BWQgik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773712625; c=relaxed/simple;
	bh=LFkPtCdrroyt2cMP02QdbDHDSW5+BFTCfBDxRFaiTNs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SCdIAGo1s2de7FTx0fjIKOpoDN/wgJ+Pt0vO8oVsYuQBDt8pQqYSLGCOiP4REg2M5gqcXTvvkI6PslWK7feXKd6/59UgO57WSHKEKHlophvKoWcPX2Srcb38a9fw9rpRIRCf+zlVif6j1fBgzWjAJb5jDB7BV2dkojrSDDrb/KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxccDstLhplMkbAA--.21519S3;
	Tue, 17 Mar 2026 09:57:00 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCx+8HqtLhpHMRWAA--.33973S3;
	Tue, 17 Mar 2026 09:56:58 +0800 (CST)
Subject: Re: [PATCH bpf-next v1 1/2] selftests/bpf: Check alignment flag if
 expected result is REJECT
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Hengqi Chen <hengqi.chen@gmail.com>,
 loongarch@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260310064507.4228-1-yangtiezhu@loongson.cn>
 <20260310064507.4228-2-yangtiezhu@loongson.cn>
 <DH02R7I6EAUH.16649BMB7V1N8@etsalapatis.com>
 <fe04d981-fc83-0ba6-4dee-8fc0c953e09f@loongson.cn>
 <abKHi9Pr5iUbIQZI@mail.gmail.com>
 <7ea56716-fd5f-1740-e634-1dec4196dd2c@loongson.cn>
 <abf_8FcnQr50CCTn@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <27a347aa-d360-a026-d5d0-e879597ccac5@loongson.cn>
Date: Tue, 17 Mar 2026 09:56:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <abf_8FcnQr50CCTn@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx+8HqtLhpHMRWAA--.33973S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Xr1kWrW7Gr1Dtw4kCF4kAFc_yoW3Xrb_Xa
	4UCw4Duw1DAw45t3Z8tFs0yF90q39rX348J3yIgryUXF9xJFyDJr4jgr9aqa15JFW29as3
	KF4vvayYqr1jyosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUU
	U

On 2026/3/16 下午9:04, Paul Chaignon wrote:
> On Thu, Mar 12, 2026 at 07:06:38PM +0800, Tiezhu Yang wrote:
>> On 03/12/2026 05:29 PM, Paul Chaignon wrote:
>>> On Thu, Mar 12, 2026 at 02:59:57PM +0800, Tiezhu Yang wrote:
> 
> [...]
> 
>>>> -#14/p Dest pointer in r0 - succeed, check 5 OK
>>>> +#14/p Dest pointer in r0 - succeed, check 5 OK (NOTE: not executed due to
>>>> unknown alignment)
>>>
>>> As stated in my previous answer, this note would be incorrect: the
>>> program was executed in test case #14 because it was rejected, not
>>> because of unknown alignment.
>>
>> OK, please ignore this patch.
> 
> I think the second patch in this set is still worthwhile, so maybe
> resend it on its own?

OK, will do it as soon as possible.

Thanks,
Tiezhu

